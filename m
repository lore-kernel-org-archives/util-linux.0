Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gh0-f174.google.com ([209.85.160.174]:57967 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab2FONJV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 Jun 2012 09:09:21 -0400
Received: by ghrr11 with SMTP id r11so2251040ghr.19
        for <util-linux@vger.kernel.org>; Fri, 15 Jun 2012 06:09:20 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Jun 2012 10:09:16 -0300
Message-ID: <CAJZVDJCK3Z_u_2TYrFMdjhjNXAJgW2C9rGnwv4RdEkcca92C7Q@mail.gmail.com>
Subject: lsblk "include" option?
From: Marcos Felipe Rasia de Mello <marcosfrm@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lsblk has an "exclude" (-e, --exclude) option. I wonder if would be
possible to add an "include" option to tell it to show *only*
specified major number devices. Like

lsblk -i 8

to only print major number 8 devices.

Regards,

Marcos
