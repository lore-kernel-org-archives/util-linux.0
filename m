Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47703 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3F3SLt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Jun 2013 14:11:49 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so2386750wiw.13
        for <util-linux@vger.kernel.org>; Sun, 30 Jun 2013 11:11:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: Addition to earlier pull request
Date: Sun, 30 Jun 2013 19:11:21 +0100
Message-Id: <1372615882-11589-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

The following patch is addition to patch set sent at June 16th, and it
should fix unstable dmesg time stamps.  Notice that the patch will not
apply to origin/master (90a0e97).

[PATCH 16/15] dmesg: make time stamps to be printed consistently

p.s. Special thanks to Kay Sievers who made me aware of
clock_gettime(CLOCK_BOOTTIME, ...);

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
