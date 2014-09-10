Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48298 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaIJHDs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Sep 2014 03:03:48 -0400
Received: by mail-ob0-f173.google.com with SMTP id uy5so13038555obc.18
        for <util-linux@vger.kernel.org>; Wed, 10 Sep 2014 00:03:47 -0700 (PDT)
Message-ID: <540FF7D1.4010608@gmail.com>
Date: Wed, 10 Sep 2014 02:03:45 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: helmut@hullen.de
CC: Helmut Hullen <hhullen@aktivanet.de>, util-linux@vger.kernel.org
Subject: Re: mount error message
References: <D0PbA82ReQB@helmut.hullen.de>
In-Reply-To: <D0PbA82ReQB@helmut.hullen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Helmut Hullen wrote:
> Hallo, Bruce,
>
> Du meintest am 07.09.14:
>
>> I have a user that complains that mount is giving an incorrect error
>> message under some circumstances.  For instance if mtab is symlinked
>> to /proc/self/mounts the command and /run is not in fstab:
>
>> $ mount /run
>
>> returns an error message:
>
>>     mount: /run: No such file or directory
>
>> However if mtab is a regular file, the error message is:
>
>>     mount: can't find /run in /etc/fstab
>
>> It would be appropriate if both situations could return the 2nd
>> message.
>
> There's no need to put the device into a special line in "/etc/fstab".
>
>          mount /dev/sdxn /run
>
> should always work, with the appropriate values for x and n.

Unless your script does not know what x or n are in advance.

Actually I followed up my original post and said the it was invalid.

   -- Bruce
