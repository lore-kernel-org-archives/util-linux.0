Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45038 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab1FGNrW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jun 2011 09:47:22 -0400
Received: by bwz15 with SMTP id 15so4190205bwz.19
        for <util-linux@vger.kernel.org>; Tue, 07 Jun 2011 06:47:21 -0700 (PDT)
MIME-Version: 1.0
From: "KESHAV P.R." <skodabenz@gmail.com>
Date: Tue, 7 Jun 2011 19:17:01 +0530
Message-ID: <BANLkTikcxGrwfoTDbphnW16s52dqKcgSBg@mail.gmail.com>
Subject: support for PARTUUID in blkid
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
     Is it possible to add support for PARTUUID to device name
conversion in blkid similar to FS UUID. The PARTUUID mentioned here is
the ID_PART_ENTRY_UUID output of 'blkid -p -i -o udev /dev/sda1' (for
example). What I want is the support for PARTUUID in 'blkid -U
<PARTUUID>' (not exactly -U , a similar command). Is it possible to
implement? Sorry I am not a programmer. This request is mainly to
support https://github.com/falconindy/geninit/commit/72272da8a855d9551c04de9ba502f3befb2a91d5
. Thanks in advance.

Regards.

Keshav
