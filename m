Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36308 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbHGCfA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 6 Aug 2015 22:35:00 -0400
Received: by ykeo23 with SMTP id o23so78505567yke.3
        for <util-linux@vger.kernel.org>; Thu, 06 Aug 2015 19:35:00 -0700 (PDT)
MIME-Version: 1.0
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 6 Aug 2015 19:34:40 -0700
Message-ID: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
Subject: fdisk BSD disklabel support?
To: util-linux@vger.kernel.org
Cc: alpha@gentoo.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm not able to figure out how to make a BSD disklabel in fdisk since v2.23.

Gentoo's installation guide describes the process of partitioning a
disk for SRM/Alpha [1]. How should one do this now?

With my distro's util-linux-2.25 I don't see any option that resembles
BSD disklabels -- I see only

  Create a new label
   g   create a new empty GPT partition table
   G   create a new empty SGI (IRIX) partition table
   o   create a new empty DOS partition table
   s   create a new empty Sun partition table

What am I missing?

[1] https://wiki.gentoo.org/wiki/Handbook:Alpha/Installation/Disks#Deleting_all_slices
