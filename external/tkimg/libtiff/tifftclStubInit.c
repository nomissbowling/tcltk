/*
 * tifftclStubInit.c --
 */

#include "tifftcl.h"

/*
 * Remove macros that will interfere with the definitions below.
 */


/*
 * WARNING: The contents of this file is automatically generated by the
 * genStubs.tcl script. Any modifications to the function declarations
 * below should be made in the tifftcl.decls script.
 */

/* !BEGIN!: Do not edit below this line. */

const TifftclStubs tifftclStubs = {
    TCL_STUB_MAGIC,
    0,
    TIFFGetVersion, /* 0 */
    TIFFFindCODEC, /* 1 */
    TIFFRegisterCODEC, /* 2 */
    TIFFUnRegisterCODEC, /* 3 */
    _TIFFmalloc, /* 4 */
    _TIFFrealloc, /* 5 */
    _TIFFmemset, /* 6 */
    _TIFFmemcpy, /* 7 */
    _TIFFmemcmp, /* 8 */
    _TIFFfree, /* 9 */
    TIFFClose, /* 10 */
    TIFFFlush, /* 11 */
    TIFFFlushData, /* 12 */
    TIFFGetField, /* 13 */
    TIFFVGetField, /* 14 */
    TIFFGetFieldDefaulted, /* 15 */
    TIFFVGetFieldDefaulted, /* 16 */
    TIFFReadDirectory, /* 17 */
    TIFFScanlineSize, /* 18 */
    TIFFRasterScanlineSize, /* 19 */
    TIFFStripSize, /* 20 */
    TIFFVStripSize, /* 21 */
    TIFFTileRowSize, /* 22 */
    TIFFTileSize, /* 23 */
    TIFFVTileSize, /* 24 */
    TIFFDefaultStripSize, /* 25 */
    TIFFDefaultTileSize, /* 26 */
    TIFFFileno, /* 27 */
    TIFFGetMode, /* 28 */
    TIFFIsTiled, /* 29 */
    TIFFIsByteSwapped, /* 30 */
    TIFFIsUpSampled, /* 31 */
    TIFFIsMSB2LSB, /* 32 */
    TIFFCurrentRow, /* 33 */
    TIFFCurrentDirectory, /* 34 */
    TIFFNumberOfDirectories, /* 35 */
    TIFFCurrentDirOffset, /* 36 */
    TIFFCurrentStrip, /* 37 */
    TIFFCurrentTile, /* 38 */
    TIFFReadBufferSetup, /* 39 */
    TIFFWriteBufferSetup, /* 40 */
    TIFFWriteCheck, /* 41 */
    TIFFCreateDirectory, /* 42 */
    TIFFLastDirectory, /* 43 */
    TIFFSetDirectory, /* 44 */
    TIFFSetSubDirectory, /* 45 */
    TIFFUnlinkDirectory, /* 46 */
    TIFFSetField, /* 47 */
    TIFFVSetField, /* 48 */
    TIFFWriteDirectory, /* 49 */
    0, /* 50 */
    TIFFPrintDirectory, /* 51 */
    TIFFReadScanline, /* 52 */
    TIFFWriteScanline, /* 53 */
    TIFFReadRGBAImage, /* 54 */
    TIFFReadRGBAStrip, /* 55 */
    TIFFReadRGBATile, /* 56 */
    TIFFRGBAImageOK, /* 57 */
    TIFFRGBAImageBegin, /* 58 */
    TIFFRGBAImageGet, /* 59 */
    TIFFRGBAImageEnd, /* 60 */
    TIFFOpen, /* 61 */
    TIFFFdOpen, /* 62 */
    TIFFClientOpen, /* 63 */
    TIFFFileName, /* 64 */
    TIFFError, /* 65 */
    TIFFWarning, /* 66 */
    TIFFSetErrorHandler, /* 67 */
    TIFFSetWarningHandler, /* 68 */
    TIFFSetTagExtender, /* 69 */
    TIFFComputeTile, /* 70 */
    TIFFCheckTile, /* 71 */
    TIFFNumberOfTiles, /* 72 */
    TIFFReadTile, /* 73 */
    TIFFWriteTile, /* 74 */
    TIFFComputeStrip, /* 75 */
    TIFFNumberOfStrips, /* 76 */
    TIFFReadEncodedStrip, /* 77 */
    TIFFReadRawStrip, /* 78 */
    TIFFReadEncodedTile, /* 79 */
    TIFFReadRawTile, /* 80 */
    TIFFWriteEncodedStrip, /* 81 */
    TIFFWriteRawStrip, /* 82 */
    TIFFWriteEncodedTile, /* 83 */
    TIFFWriteRawTile, /* 84 */
    TIFFSetWriteOffset, /* 85 */
    TIFFSwabShort, /* 86 */
    TIFFSwabLong, /* 87 */
    TIFFSwabDouble, /* 88 */
    TIFFSwabArrayOfShort, /* 89 */
    TIFFSwabArrayOfLong, /* 90 */
    TIFFSwabArrayOfDouble, /* 91 */
    TIFFReverseBits, /* 92 */
    TIFFGetBitRevTable, /* 93 */
    TIFFErrorExt, /* 94 */
    TIFFGetStrileByteCount, /* 95 */
    TIFFGetStrileOffset, /* 96 */
    0, /* 97 */
    0, /* 98 */
    0, /* 99 */
    TIFFPredictorInit, /* 100 */
    TIFFPredictorCleanup, /* 101 */
    0, /* 102 */
    0, /* 103 */
    0, /* 104 */
    0, /* 105 */
    0, /* 106 */
    0, /* 107 */
    0, /* 108 */
    0, /* 109 */
    0, /* 110 */
    TIFFMergeFieldInfo, /* 111 */
    _TIFFPrintFieldInfo, /* 112 */
    0, /* 113 */
    TIFFFieldWithTag, /* 114 */
    _TIFFMergeFields, /* 115 */
    0, /* 116 */
    0, /* 117 */
    0, /* 118 */
    0, /* 119 */
    _TIFFgetMode, /* 120 */
    _TIFFNoRowEncode, /* 121 */
    _TIFFNoStripEncode, /* 122 */
    _TIFFNoTileEncode, /* 123 */
    _TIFFNoRowDecode, /* 124 */
    _TIFFNoStripDecode, /* 125 */
    _TIFFNoTileDecode, /* 126 */
    _TIFFNoPostDecode, /* 127 */
    _TIFFNoPreCode, /* 128 */
    _TIFFNoSeek, /* 129 */
    _TIFFSwab16BitData, /* 130 */
    _TIFFSwab32BitData, /* 131 */
    _TIFFSwab64BitData, /* 132 */
    TIFFFlushData1, /* 133 */
    TIFFFreeDirectory, /* 134 */
    TIFFDefaultDirectory, /* 135 */
    TIFFSetCompressionScheme, /* 136 */
    _TIFFSetDefaultCompressionState, /* 137 */
    _TIFFDefaultStripSize, /* 138 */
    _TIFFDefaultTileSize, /* 139 */
    _TIFFsetByteArray, /* 140 */
    _TIFFsetString, /* 141 */
    _TIFFsetShortArray, /* 142 */
    _TIFFsetLongArray, /* 143 */
    _TIFFsetFloatArray, /* 144 */
    _TIFFsetDoubleArray, /* 145 */
    _TIFFprintAscii, /* 146 */
    _TIFFprintAsciiTag, /* 147 */
    TIFFInitDumpMode, /* 148 */
#if !defined(PACKBITS_SUPPORT)
    0, /* 149 */
#else  /* !PACKBITS_SUPPORT */
    TIFFInitPackBits, /* 149 */
#endif /* !PACKBITS_SUPPORT */
#if !defined(CCITT_SUPPORT)
    0, /* 150 */
#else  /* !CCITT_SUPPORT */
    TIFFInitCCITTRLE, /* 150 */
#endif /* !CCITT_SUPPORT */
#if !defined(CCITT_SUPPORT)
    0, /* 151 */
#else  /* !CCITT_SUPPORT */
    TIFFInitCCITTRLEW, /* 151 */
#endif /* !CCITT_SUPPORT */
#if !defined(CCITT_SUPPORT)
    0, /* 152 */
#else  /* !CCITT_SUPPORT */
    TIFFInitCCITTFax3, /* 152 */
#endif /* !CCITT_SUPPORT */
#if !defined(CCITT_SUPPORT)
    0, /* 153 */
#else  /* !CCITT_SUPPORT */
    TIFFInitCCITTFax4, /* 153 */
#endif /* !CCITT_SUPPORT */
#if !defined(THUNDER_SUPPORT)
    0, /* 154 */
#else  /* !THUNDER_SUPPORT */
    TIFFInitThunderScan, /* 154 */
#endif /* !THUNDER_SUPPORT */
#if !defined(NEXT_SUPPORT)
    0, /* 155 */
#else  /* !NEXT_SUPPORT */
    TIFFInitNeXT, /* 155 */
#endif /* !NEXT_SUPPORT */
#if !defined(LZW_SUPPORT)
    0, /* 156 */
#else  /* !LZW_SUPPORT */
    TIFFInitLZW, /* 156 */
#endif /* !LZW_SUPPORT */
#if !defined(OJPEG_SUPPORT)
    0, /* 157 */
#else  /* !OJPEG_SUPPORT */
    TIFFInitOJPEG, /* 157 */
#endif /* !OJPEG_SUPPORT */
#if !defined(JPEG_SUPPORT)
    0, /* 158 */
#else  /* !JPEG_SUPPORT */
    TIFFInitJPEG, /* 158 */
#endif /* !JPEG_SUPPORT */
#if !defined(JBIG_SUPPORT)
    0, /* 159 */
#else  /* !JBIG_SUPPORT */
    TIFFInitJBIG, /* 159 */
#endif /* !JBIG_SUPPORT */
#if !defined(ZIP_SUPPORT)
    0, /* 160 */
#else  /* !ZIP_SUPPORT */
    TIFFInitZIP, /* 160 */
#endif /* !ZIP_SUPPORT */
#if !defined(PIXARLOG_SUPPORT)
    0, /* 161 */
#else  /* !PIXARLOG_SUPPORT */
    TIFFInitPixarLog, /* 161 */
#endif /* !PIXARLOG_SUPPORT */
#if !defined(LOGLUV_SUPPORT)
    0, /* 162 */
#else  /* !LOGLUV_SUPPORT */
    TIFFInitSGILog, /* 162 */
#endif /* !LOGLUV_SUPPORT */
    _TIFFMultiplySSize, /* 163 */
};

/* !END!: Do not edit above this line. */
