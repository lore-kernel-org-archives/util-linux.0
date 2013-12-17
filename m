Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:55880 "EHLO Ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab3LQXiN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Dec 2013 18:38:13 -0500
Received: from [192.168.4.12] (Athenae [192.168.4.12])
	by Ishtar.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id rBHNCtl5045761
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2013 15:12:57 -0800
Message-ID: <52B0DA78.8060109@tlinx.org>
Date: Tue, 17 Dec 2013 15:12:56 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: regression bug: user loses DISPLAY & REMOTEHOST with  'su -p - username"
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


"su --preserve_environment - username" no longer preserves
your REMOTEHOST and DISPLAY values.  They should be
in the same class as 'TERM', as they are passed from the
pre-login environment.

I don't know if there are other values that shouldn't be
removed -- but it is bad to clear the environment just
because one wants a shell called with '-<shell>'.

The preserve environment flag is NOT incompatible with login.
It means don't clear the env, but do call login via -<shell>.

-p means don't clear the ENV -- but do call the user's shell
with a '-' in front of it.  That has always been the functionality
of 'su'.

If you want to make 'su' fancier, maybe it needs a "/etc/suers.conf"
file so specific values can be easily changed to reflect
site policy rather than hard coding them.







