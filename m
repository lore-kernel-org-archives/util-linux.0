Return-Path: util-linux-owner@vger.kernel.org
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:6368 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2C0Rwy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Mar 2012 13:52:54 -0400
Message-ID: <4F71FE73.9010208@intellitree.com>
Date: Tue, 27 Mar 2012 13:52:51 -0400
From: Michael Conrad <mconrad@intellitree.com>
MIME-Version: 1.0
To: "Ted Ts'o" <tytso@mit.edu>
CC: util-linux@vger.kernel.org
Subject: Re: blkid -o value
References: <4F71F836.4000103@intellitree.com> <20120327173149.GC10142@thunk.org>
In-Reply-To: <20120327173149.GC10142@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3/27/2012 1:31 PM, Ted Ts'o wrote:
> On Tue, Mar 27, 2012 at 01:26:14PM -0400, Michael Conrad wrote:
>> I would request that either the order of fields become stable by
>> printing empty lines for missing fields (and documented), or the "-o
>> value" be done away with, since I can't see any reason anyone would
>> want random output in a script-friendly format, and the fact that it
>> exists is likely to lead people astray.
> Try using this way, which was its intended usage:
>
> blkid -o value -s TYPE -t UUID=a3dc6f56-da22-4079-bf75-1fa2ce1aa4b0
>
> (replace part following -t with the search criteria you want; for
> example, "-t LABEL=backup").
>
> It was intended to be used a script-friendly way, and I believe there
> are shell scripts using in this fashion.  So please don't change blkid
> -o value.

I see how that could be useful if and only if you use exactly one "-s", 
but if you requested more than one "-s" they still come out in 
non-stable order.  It's like running a SQL query and having all the 
columns shifted because the first one was a NULL.  If you're on a system 
where all the volumes have labels, types, and uuids (and nothing else) 
it's very misleading.

At the very least, I would appreciate it if the man page mentioned that 
"-o value" should only ever be used with exactly one "-s".

-Mike
