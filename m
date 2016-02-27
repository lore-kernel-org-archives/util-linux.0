Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34772 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbcB0Sqi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Feb 2016 13:46:38 -0500
Received: by mail-yw0-f176.google.com with SMTP id h129so93066742ywb.1
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 10:46:37 -0800 (PST)
MIME-Version: 1.0
From: Akshay Adiga <akshay.adiga@gmail.com>
Date: Sun, 28 Feb 2016 00:16:17 +0530
Message-ID: <CAOaMnuGfN1hnEn7H95c2TzxyQUoQ3c5PzikApHMPyPW123R9fQ@mail.gmail.com>
Subject: Separate taskset arguments from the command arguments
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I want to run a command which looks something like this :

taskset -c 10 ycsb -p "redis_host=1234"

The actual command is :

ycsb -p "redis_host=1234"

But argument -p "redis_host=1234" is taken by taskset as it argument
and throws an error : Failed to set pid 0's affinity:

-p "redis_host=1234" is an argument to ycsb command. shell/tasket
misunderstands that and takes it as an argument for taskset.

Is there a work around for this?

--
Regards --
Akshay Adiga
