Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48828 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbaLJCkm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Dec 2014 21:40:42 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so1822073pab.16
        for <util-linux@vger.kernel.org>; Tue, 09 Dec 2014 18:40:41 -0800 (PST)
Received: from madrid.europa ([73.162.159.24])
        by mx.google.com with ESMTPSA id oy7sm2600376pbc.88.2014.12.09.18.40.40
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 18:40:40 -0800 (PST)
From: Will Johansson <will.johansson@gmail.com>
To: util-linux@vger.kernel.org
Subject: login-utils: Enable building util-linux against OpenPAM 
Date: Tue,  9 Dec 2014 18:40:30 -0800
Message-Id: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I recently experimented with cross-compiling for embedded devices, and
sought to try out util-linux with OpenPAM instead of Linux-PAM because
OpenPAM was simpler to cross-compile. Unfortunately for me, it did not
work out of the box, so I decided to try to patch util-linux to support
compiling against OpenPAM. Turned out to be a fairly simple exercise.

This is the fruit of my efforts. There is a caveat, which I will
be happy to address if it's a problem. The patch's configuration does
not support building if you happen to have both Linux-PAM and OpenPAM
in your build paths. I could update it to prefer Linux-PAM by default.
I'm not sure how it'd would work if OpenPAM libraries is also in the
search path, as -lpam is used by both Linux-PAM and OpenPAM (probably
undefined behavior).

Either way, it should compile fine against Linux-PAM and OpenPAM.
There are some unused variables in login.c, but seems to have to do
with _HAVE_UT_TV, which is not the case in my configuration. I'm
more than happy to provide a separate patch to wrap the unused
variables with an #ifdef _HAVE_UT_TV.

Warm regards,

Will Johansson

