Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51131 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab3EGFDb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 May 2013 01:03:31 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so157917wgg.21
        for <util-linux@vger.kernel.org>; Mon, 06 May 2013 22:03:30 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 May 2013 08:03:29 +0300
Message-ID: <CAF0Lin2vFqLg3J_nhSkpdmzYuB56ZNn2TNqrZbSTynMB3x5Tew@mail.gmail.com>
Subject: Cannot allocate memory when calling unshare
From: Andy Johnson <johnsonzjo@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
I use git last update of util-linux.

./unshare -n /bin/bash
works ok.

>From a different terminal I run:

./unshare -p /bin/bash
and get:
bash: fork: Cannot allocate memory

typing:
shows 141 Mb free.

the machine has x86_64 ubuntu, 13.04, Raring Ringtail

any advice ?

Best,

Andy
