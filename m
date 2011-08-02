Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46802 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab1HBVy6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Aug 2011 17:54:58 -0400
Received: by gxk21 with SMTP id 21so145507gxk.19
        for <util-linux@vger.kernel.org>; Tue, 02 Aug 2011 14:54:58 -0700 (PDT)
Message-ID: <4E387230.5060002@gmail.com>
Date: Tue, 02 Aug 2011 16:54:56 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: umount -a
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

At linuxfromscratch, we've just made some changes to write bootscript 
messages to /run/var.  This seems to work fine for us until shutdown where

   umaount -a

unmounts /run which is mounted as a tmpfs.  We can certainly work around 
the problem, but was wondering if this issue may also affect others.

The man page for umount says:

  -a     All of the file systems described in /etc/mtab are unmounted.
(With umount version 2.7 and later: the proc filesystem is not
unmounted.)

Would it be reasonable to change umount -a to also omit /run if it is 
mounted as a tmpfs?

   -- Bruce
