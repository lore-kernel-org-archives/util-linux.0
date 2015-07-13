Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f49.google.com ([209.85.215.49]:34381 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbGMH70 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 13 Jul 2015 03:59:26 -0400
MIME-Version: 1.0
Date: Mon, 13 Jul 2015 10:59:24 +0300
Message-ID: <CAK13fG4CfFQCWLidruBfZ786ri9B_ov8C60q7it9NfgURvuc=w@mail.gmail.com>
Subject: fdisk - mistyping in gpt type table (one character)
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCT0LDQstGA0LjQu9C40L0=?=
	<gaal.dev@gmail.com>
To: majordomo@vger.kernel.org, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

GUID Partition Table: MidnightBSD

85D5E45E-237C-11E1-B4B3-E89A8F7FC3A7    Boot partition
85D5E45A-237C-11E1-B4B3-E89A8F7FC3A7    Data partition
85D5E45B-237C-11E1-B4B3-E89A8F7FC3A7    Swap partition
0394EF8B-237E-11E1-B4B3-E89A8F7FC3A7    Unix File System (UFS) partition
85D5E45C-237C-11E1-B4B3-E89A8F7FC3A7    Vinum volume manager partition
85D5E45D-237C-11E1-B4B3-E89A8F7FC3A7    ZFS partition

util-linux-2.26/libfdisk/src/gpt.c:235

Original code:

        DEF_GUID("85D5E45A-237C-11E1-B4B3-E89A8F7FC3A7",
N_("MidnightBSD data")),
        DEF_GUID("85D5E45E-237C-11E1-B4B3-E89A8F7FC3A7",
N_("MidnightBSD boot")),
        DEF_GUID("85D5E45B-237C-11E1-B4B3-E89A8F7FC3A7",
N_("MidnightBSD swap")),
        DEF_GUID("0394Ef8B-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD UFS")),
        DEF_GUID("85D5E45D-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD ZFS")),
        DEF_GUID("85D5E45C-237C-11E1-B4B3-E89A8F7FC3A7",
N_("MidnightBSD Vinum")),

One string has to be replaced.

        DEF_GUID("0394EF8B-237E-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD UFS")),
