Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.bitmessage.ch ([146.228.112.252]:56947 "EHLO
        mail.bitmessage.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeHSABI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 18 Aug 2018 20:01:08 -0400
Date: Sat, 18 Aug 2018 21:21:40 +0100
From: =?utf-8?B?Sm/Do28=?= Miguel <jmcf125@bitmessage.ch>
To: util-linux@vger.kernel.org
Subject: Suggestion for new multi-mount option
Message-ID: <20180818202140.GE4715@jmcf125-Acer-GNU-Linux.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi there,

First, some background: recently I've setup a few (too many) hard-drive
backups and new systems with LVM, lots of partitions and weird options
I'd put in the respective /etc/fstab. I don't want to write all that
shit every time I want to mount a system in /mnt/something, I wanted
«mount» to read my fstab, but although it has the «--fstab» option, it
doesn't allow me to mount anywhere but in /.

So I'm not sure if this is welcome here, but I don't really know C to
make the suggestion a patch, although it seems simple enough. Here's a
script, let's call it mount-relative:

#!/bin/bash
_dev="$1"
_mnt="$2"
_tmp="$(mktemp /tmp/fstab-XXXXX)"
mount -v "$1" "$2"
grep -Ev '(^#|swap|^$)' "$_mnt/etc/fstab" \
   | sed -E -e 's#\s+([^\s]+)# '"$_mnt"'\1#' \
            -e 's/(noauto,|,noauto|noauto)//g' \
   | cat >"$_tmp"
mount -av --fstab "$_tmp"
rm -vi "$_tmp"

(Note: I'm filtering «noauto» in a dumb way because I'm lazy and it's a
simple script)

As I've been using:

   mount-relative /dev/something /mnt/somewhere

I think it would be useful for it to be doable with «mount» as:

   mount --relative-root /dev/something /mnt/somewhere

Or at least:

   mount /dev/something /mnt/somewhere
   mount -a --fstab /mnt/somewhere/etc/fstab --relative /mnt/somewhere


Maybe also a «--ignore-noauto», as using «-o auto» in the script doesn't
seem to work (probably because «-o» is not made for usage with «--fstab»
and «-a»).

In case you don't consider this a good option for mount, well, have the
script, it has been very useful to me.

Best regards,
João Miguel
