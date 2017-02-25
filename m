Return-Path: elseifthen@gmx.com
Subject: [V2 3/4] hwclock: add hwclock-date files
To: Karel Zak <kzak@redhat.com>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <44df4d4e-3df0-a2ca-397b-4d4e3d896607@gmx.com>
Date: Sat, 25 Feb 2017 13:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


new file: sys-utils/hwclock-date.y
new file: include/cctype.h
	Like ctype.h, only hard coded to the 'C' locale.
	Functions are prefixed with c_, e.g., c_isalpha()

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/cctype.h         |  357 +++++++
 sys-utils/hwclock-date.y | 2427 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2784 insertions(+)
 create mode 100644 include/cctype.h
 create mode 100644 sys-utils/hwclock-date.y

This patch was too long to post.
