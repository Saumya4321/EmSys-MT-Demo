/***************************************************************************//**
 * (c) Copyright 2014-2015 Microsemi SoC Products Group.  All rights reserved.
 * crc32 header file.
 *
 * SVN $Revision: 7666 $
 * SVN $Date: 2015-08-18 14:49:20 +0530 (Tue, 18 Aug 2015) $
 *
 ******************************************************************************/

#ifndef __CRC32_H
#define __CRC32_H    1

#include <cpu_types.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Calculates 32 bits CRC value of given data */
uint32_t
TSE_crc32
(
    uint32_t value,
    const uint8_t *data,
    uint32_t data_length
);

/*Calculates 32 bit CRC value of given data,using standard Ethernet CRC function*/
uint32_t
TSE_ethernet_crc
(
    const uint8_t *data,
    uint32_t data_length
);

#ifdef __cplusplus
}
#endif

#endif    /* __CRC32_H */
