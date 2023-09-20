#include <windows.h>
#include <winnt.h>
#include <fileapi.h>
#include <stdint.h>

typedef union {
    const IMAGE_SECTION_HEADER *hdr;
    const uint8_t *base;
} objhdr;

static objhdr obj;

static void load_obj(void)
{
    // Buka file yang akan di-mapping.
    HANDLE fileHandle = CreateFile(
        ".\\arithmetic.o",                // Nama file yang akan di-mapping.
        GENERIC_READ,                  // Akses hanya untuk membaca.
        FILE_SHARE_READ,               // Share mode.
        NULL,                          // Security attributes.
        OPEN_EXISTING,                 // Buka file yang ada.
        FILE_ATTRIBUTE_NORMAL,          // Atribut file.
        NULL                           // Handle template.
    );

    if (fileHandle == INVALID_HANDLE_VALUE) {
        printf("Gagal membuka file. Error code: %d\n", GetLastError());
        return 1;
    }

    // Dapatkan ukuran file.
    LARGE_INTEGER fileSize;
    if (!GetFileSizeEx(fileHandle, &fileSize)) {
        printf("Gagal mendapatkan ukuran file. Error code: %d\n", GetLastError());
        CloseHandle(fileHandle);
        return 1;
    }

    // Dapatkan ukuran halaman sistem.
    SYSTEM_INFO systemInfo;
    GetSystemInfo(&systemInfo);
    DWORD pageSize = systemInfo.dwPageSize;

    printf("Ukuran file: %lld bytes\n", fileSize.QuadPart);
    printf("Ukuran halaman sistem: %d bytes\n", pageSize);

    // Buat file mapping object.
    HANDLE mappingHandle = CreateFileMapping(
        fileHandle,                    // Handle file.
        NULL,                          // Security attributes.
        PAGE_READONLY,                 // Proteksi read-only.
        0,                             // Ukuran high-order DWORD.
        0,                             // Ukuran low-order DWORD.
        NULL                           // Nama objek.
    );

    if (mappingHandle == NULL) {
        printf("Gagal membuat file mapping object. Error code: %d\n", GetLastError());
        CloseHandle(fileHandle);
        return 1;
    }

    // Map file ke dalam alamat virtual.
    LPVOID mapView = MapViewOfFile(
        mappingHandle,                 // Handle file mapping object.
        FILE_MAP_READ,                // Akses hanya untuk membaca.
        0,                            // Offset high-order DWORD.
        0,                            // Offset low-order DWORD.
        0                             // Ukuran memetakan (0 untuk seluruh file).
    );

    if (mapView == NULL) {
        printf("Gagal memetakan file ke dalam memory. Error code: %d\n", GetLastError());
        CloseHandle(mappingHandle);
        CloseHandle(fileHandle);
        return 1;
    }

    // Lakukan operasi dengan file yang sudah dimapping di sini.
    obj.base = mapView;
    
    // Unmap file saat selesai.
    UnmapViewOfFile(mapView);
    CloseHandle(mappingHandle);
    CloseHandle(fileHandle);
}

static void parse_obj(void)
{
    /* parse an object file and find add5 and add10 functions */
}

static void execute_funcs(void)
{
    /* execute add5 and add10 with some inputs */
}

int main(void)
{
    load_obj();
    parse_obj();
    execute_funcs();

    return 0;
}