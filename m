Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f41.google.com ([209.85.210.41]:54118 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3ACDWR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 22:22:17 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so6802176dak.28
        for <util-linux@vger.kernel.org>; Wed, 02 Jan 2013 19:22:16 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH 0/3] Add support for using libuser to chsh
Date: Wed,  2 Jan 2013 20:21:58 -0700
Message-Id: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add support for libuser to chsh. This follows lchsh which is packaged with
libuser. If this set looks good, I will add libuser support to chfn.

Cody Maloney (3):
  chsh-chfn: Add flag for enabling/disabling libuser support.
  chsh: Move pam auth to its own function.
  chsh: Add libuser support

 configure.ac              |  17 ++++++
 login-utils/Makemodule.am |   5 ++
 login-utils/chsh.c        | 137 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 135 insertions(+), 24 deletions(-)

-- 
1.8.1

