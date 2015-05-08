Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61797 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768AbbEHNoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 May 2015 09:44:24 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (gpt) fix attributes endianess
Date: Fri, 8 May 2015 15:44:20 +0200
Cc: Michael Marineau <michael.marineau@coreos.com>
References: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201505081544.20751.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 08 May 2015, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> The new libfdisk/gpt test (4a4a0927) discovered that we read and
> write partition attributes wrongly on BE systems.

To be more clear ... this does not mean that 4a4a0927 is broken but the 
test shows that sfdisk (and fdisk) is.

Introduced at least since 01086b80 (2014-03-13) and c77ba531 
(2014-10-02).

Some notes how to reproduce.

## create gpt image
$ truncate -s 10M img
$ ./sfdisk --unit S img <<EOF
label: gpt
size=5M, attrs=""
EOF

## Both commands should do the same
$ ./sfdisk --part-attrs img 1 RequiredPartiton
$ ./test_fdisk_gpt --setattr img 1 "0x0000000000000001"

## So that for both cases and any endianess we should get
$ ./sfdisk --part-attrs img 1
RequiredPartiton
## and
$ ./test_fdisk_gpt --getattr img 1
1: 0x0000000000000001
## on disk it's always little endian
$ hexdump -C img  | grep 009fbe30
009fbe30  01 00 00 00 00 00 00 00  ....


cu,
Rudi
