Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:58680 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756728AbcB0Ww3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 17:52:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZnis-0007ZG-I7
	for util-linux@vger.kernel.org; Sat, 27 Feb 2016 23:52:26 +0100
Received: from ppp37-190-56-21.pppoe.spdop.ru ([37.190.56.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 23:52:26 +0100
Received: from yumkam by ppp37-190-56-21.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 23:52:26 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: Separate taskset arguments from the command arguments
Date: Sun, 28 Feb 2016 01:52:20 +0300
Message-ID: <m3egbxn4uz.fsf@gmail.com>
References: <CAOaMnuGfN1hnEn7H95c2TzxyQUoQ3c5PzikApHMPyPW123R9fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Akshay Adiga <akshay.adiga@gmail.com>
writes:

> I want to run a command which looks something like this :
>
> taskset -c 10 ycsb -p "redis_host=1234"
>
> The actual command is :
>
> ycsb -p "redis_host=1234"
>
> But argument -p "redis_host=1234" is taken by taskset as it argument
> and throws an error : Failed to set pid 0's affinity:
>
> -p "redis_host=1234" is an argument to ycsb command. shell/tasket
> misunderstands that and takes it as an argument for taskset.
>
> Is there a work around for this?

Normally, such problem are solved by inserting `--` before your command;
however, taskset have somewhat unusual parsing of arguments (-c is not
an "option with argument", but the flag), so it will be

  taskset -c -- 10 ycsb -p "redis_host=1234"

