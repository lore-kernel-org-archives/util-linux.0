Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41926 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327Ab2ANAWS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Jan 2012 19:22:18 -0500
Received: by obcva7 with SMTP id va7so2886670obc.19
        for <util-linux@vger.kernel.org>; Fri, 13 Jan 2012 16:22:18 -0800 (PST)
Message-ID: <4F10CAB7.6060808@gmail.com>
Date: Fri, 13 Jan 2012 18:22:15 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: getting a modern `more`
References: <201201130128.49700.vapier@gentoo.org>	<4F10BA5A.6020001@gmail.com> <CAG27Bk0Z8Aij+Tj42pA447FN9+zTu94YEmNhe2eDPo=KW2oYeg@mail.gmail.com>
In-Reply-To: <CAG27Bk0Z8Aij+Tj42pA447FN9+zTu94YEmNhe2eDPo=KW2oYeg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:
> On Sat, Jan 14, 2012 at 00:12, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>> Does anyone still use 'more'?  The only thing needed is a symlink to 'less':
>> http://www.greenwoodsoftware.com/less/
> 
> I do.
> 
>> Are there any distros that don't provide 'less' by default?
>>
>> What value added does 'more' provide?
> 
> It does not clear screen when 'q' is pressed, which is the main reason
> I sometime choose to use more.

"COMPATIBILITY WITH MORE
   If  the  environment  variable LESS_IS_MORE is set to 1, or if the
   program is invoked via a file link named "more", less behaves
   (mostly) in  conformance  with  the  POSIX "more" command
   specification."

>> I'd think development time would be
>> better used elsewhere.  To me, 'more' was developed in the era of paper
>> terminals (e.g. Teletype) and it is time to retire it.
> 
> I appreciate highly when someone volunteers to maintain & develop
> something superficially old and obsolete. Earlier one might have said
> that why bother to make vi better now when emacs is so great, which
> lead eventually to vim. Who knows how much better more might be in
> future in comparison to less if people who like it have change of
> making it such.

You have a point here, but I would certainly suggest that the volunteer 
start with the most robust current software.  Of course there is nothing 
wrong with reviewing the older code for missing features.

   -- Bruce
