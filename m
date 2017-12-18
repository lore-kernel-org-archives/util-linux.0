Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:56552 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934862AbdLRXCv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Dec 2017 18:02:51 -0500
Message-ID: <5A384916.1020809@tlinx.org>
Date: Mon, 18 Dec 2017 15:02:46 -0800
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Build problem in 2.31
References: <5A37371F.5070307@tlinx.org> <20171218123805.tkhhuyemgntv4gie@ws.net.home> <5A37BB4F.9080004@tlinx.org> <20171218132839.x5gvn5ucdepfawee@ws.net.home>
In-Reply-To: <20171218132839.x5gvn5ucdepfawee@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Dec 18, 2017 at 04:57:51AM -0800, L A Walsh wrote:
>   
>> Running Config:
>>     
>>> ../config-231.sh#69> ./configure 'CFLAGS=-fpic -march=native -pipe -Og'
>>>       
>> 'LDFLAGS=-fpic -march=native -pipe -Og -Wl,--default-symver -Wl,--stats '
>>     
>                                          ^^^^^^^^^^^^^^^^^^^^
>  This is the evil. Try it without "-Wl,--default-symver"
>   
----
    Oh?  I didn't specify it explicitly -- not sure where it is turned
on as of yet. 

    Weird.
....
