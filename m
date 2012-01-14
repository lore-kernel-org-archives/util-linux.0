Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37874 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab2ANDRo (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Jan 2012 22:17:44 -0500
Received: by obcva7 with SMTP id va7so2964102obc.19
        for <util-linux@vger.kernel.org>; Fri, 13 Jan 2012 19:17:44 -0800 (PST)
Message-ID: <4F10F3D5.9080706@gmail.com>
Date: Fri, 13 Jan 2012 21:17:41 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: getting a modern `more`
References: <201201130128.49700.vapier@gentoo.org> <CAG27Bk0Z8Aij+Tj42pA447FN9+zTu94YEmNhe2eDPo=KW2oYeg@mail.gmail.com> <4F10CAB7.6060808@gmail.com> <201201132008.20863.vapier@gentoo.org>
In-Reply-To: <201201132008.20863.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On Friday 13 January 2012 19:22:15 Bruce Dubbs wrote:
>> "COMPATIBILITY WITH MORE
>>    If  the  environment  variable LESS_IS_MORE is set to 1, or if the
>>    program is invoked via a file link named "more", less behaves
>>    (mostly) in  conformance  with  the  POSIX "more" command
>>    specification."
> 
> you've indirectly quoted one reason for needing "more" -- POSIX wants it.
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.html

I guess my intent wasn't clear.  I wasn't advocating removing "more" 
from distros, I was saying that it's implementation via "less" is much 
more flexible and wasn't really required in util-linux.

I suppose the case can be made that 'more' at about 27K is much smaller 
and more efficient than 'less' at about 327K, but in the era of TB 
drives, I wouldn't think that would make a significant difference.  Both 
programs are generally used by users at the command line - rarely in a 
script.

That said, if you want to spend the effort to update and maintain a 
program that duplicates functionality, than that's up to you.  I just 
think you may want to be careful of NIH thinking.

   -- Bruce
