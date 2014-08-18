Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f42.google.com ([209.85.219.42]:63867 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaHRWTx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Aug 2014 18:19:53 -0400
Received: by mail-oa0-f42.google.com with SMTP id n16so4637793oag.1
        for <util-linux@vger.kernel.org>; Mon, 18 Aug 2014 15:19:52 -0700 (PDT)
Received: from [192.168.0.75] (cpe-72-178-123-130.satx.res.rr.com. [72.178.123.130])
        by mx.google.com with ESMTPSA id q3sm26002068oei.3.2014.08.18.15.19.50
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Aug 2014 15:19:51 -0700 (PDT)
Message-ID: <53F27C05.3090902@gmail.com>
Date: Mon, 18 Aug 2014 17:19:49 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Regression test failure - tests/ts/ipcs/limits2
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When testing util-linux-2.25, I was suprised to get a test failure. 
Running it down, I found tests/ts/ipcs/limits2 is doing:

if [ $(</proc/sys/kernel/shmall) -ge $(bc <<<"2^64 / $PAGE_SIZE") ];

The problem is that starting with the 3.16 kernel the shmall value is 
18446744073692774399 which is the max value of an unsigned long on a 
64-bit system (UINT64_MAX).  Bash doesn't like this value and says:

"18446744073692774399: integer expression expected"

I can work around this by setting shmall before running the test, but 
there is a problem with either the test or in the kernel.

I note that the kernel's shmmax value is also set to UINT64_MAX.

What's the best way to approach this?

   -- Bruce Dubbs
      linuxfromscratch.org
