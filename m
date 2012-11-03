Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51384 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2KCSfR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Nov 2012 14:35:17 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4750032vbb.19
        for <util-linux@vger.kernel.org>; Sat, 03 Nov 2012 11:35:14 -0700 (PDT)
Date: Sat, 3 Nov 2012 14:35:11 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: grawity@gmail.com
Subject: [bug] incorrect GPT entry validation?
Message-ID: <20121103183511.GO482@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

A user reported problems with libblkid incorrectly reporting (or not
reporting) tags for some partitions on a GPT formatted disk. I was able
to reproduce it:

- created a 10G disk on a VM
- initialized it with GPT (using gdisk), created 5 entries
- formatted each of them with ext4

blkid correctly reads the first 2 entries on the disk, but then starts
reporting corrupted GPT entries (seen via LIBBLKID_DEBUG=0xffff):

https://dev.archlinux.org/~dreisner/blkid_bad.txt

It's interesting to note that blkid will _always_ read 2 entries before
reporting corruption, i.e.

# blkid -c /dev/null /dev/vdd{4,5,2}

This shows full info for /dev/vdd4 and /dev/vdd5, but nothing for
/dev/vdd2.

Commenting out the final crc validation in libblkid/src/partitions/gpt.c
and rebuilding lets blkid continue on and it happily prints everything:

https://dev.archlinux.org/~dreisner/blkid_no_validate.txt

Of course this is entirely wrong, but I'm not familiar at all with the
internals of libblkid or GPT to understand what's misbehaving.


As an aside, I was sadly unable to create the same layout using the
shiny new fdisk:

Command (m for help): g

Command (m for help): n
Partition number (1-128): 1
First sector (34-20971486, default 34):
Using default value 34
Last sector (34-20971486, default 20971486): 2G
Value out of range.
Last sector (34-20971486, default 20971486): +2G
Created partition 1

Command (m for help): n
Partition number (1-128): 2
First sector (4194305-20971486, default 4194305): +2G
Value out of range.
First sector (4194305-20971486, default 4194305): +1G
Value out of range.
First sector (4194305-20971486, default 4194305): +1M
Value out of range.

Cheers,
Dave
