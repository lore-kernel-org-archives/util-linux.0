Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:50837 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758605AbaGYCUz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 22:20:55 -0400
Message-ID: <53D1BF03.9000201@tlinx.org>
Date: Thu, 24 Jul 2014 19:20:51 -0700
From: "Linda A. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Q: (RFE?)  How do you specify the 'no-canonicalize' option in fstab?
References: <53D08C77.6010500@tlinx.org> <20140724073222.GI26781@x2.net.home>
In-Reply-To: <20140724073222.GI26781@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Jul 23, 2014 at 09:32:55PM -0700, Linda A. Walsh wrote:
>   
>> While it works interactively, that leaves out using it when most of the file
>> systems are loaded -- how can one specify -no-canonicalize in /etc/fstab?
>>     
>
>  Why do you want something like this? 
>   
----
Why wouldn't I?


>  
>  The option --no-canonicalize has very special purpose (e.g. when
>  mount.<type> helper calls mount(8)).
>   
The default canonicalization has a very special purpose to the 
kernel/dm, but it
is not necessarily what a user wants to see when they type 'mount'.

Is there a reason NOT to give the option to user to display it as they wish,
or is there some reason to force the user into using the kernel/lvm internal
format?




