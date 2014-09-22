Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f182.google.com ([209.85.213.182]:52943 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbaIVLi0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Sep 2014 07:38:26 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so2493762igb.9
        for <util-linux@vger.kernel.org>; Mon, 22 Sep 2014 04:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140922113327.GI5366@x2.net.home>
References: <karelzak/util-linux/pull/117@github.com>
	<karelzak/util-linux/pull/117/c55868722@github.com>
	<CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
	<CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
	<20140917131848.GA5366@x2.net.home>
	<CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
	<20140922113327.GI5366@x2.net.home>
Date: Mon, 22 Sep 2014 17:38:25 +0600
Message-ID: <CAP0zEAbucyO55YyAhbUkcEB-+R8GQ1qv+XAdQYzp-bo2xB2wjQ@mail.gmail.com>
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views (#117)
From: Gennady Kovshenin <gennady@kovshenin.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Agreed. And the default would still be 3, right? For back compatibility.

What's the short version of the flag -z?

And would the auto mode try to still limit itself to a rectangle? Or
stretch indefinitely?

I appreciate your time brainstorming about this, Karel. Thank you.
Regards,
Gennady Kovshenin


On Mon, Sep 22, 2014 at 5:33 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Sep 17, 2014 at 09:52:36PM +0600, Gennady Kovshenin wrote:
>> I like the format=auto idea. But we can keep it to just the number of
>> columns instead of a full CxR format.
>
>  It would be the best to talk about number of months ;-)
>
>> i.e. format=2 (2x6), format=3 (3x4), format=4 (4x3), and so on.
>> perhaps the parameter should be called --columns/-c instead of format.
>> We can either have an additional auto value to the format, or have it
>> be on by default.
>> Having auto on by default means breaking compatibility. Some users
>> might be parsing output expecting the default 3x4 view in place and if
>> we abruptly change this to be stretched automatically their scripts
>> might break.
>>
>> Any thoughts on the above? --format vs. --columns? And the default
>> value thereof.
>
> Or something else --horizontal-months[=<num>|auto]
>
> and think we can support arbitrary <num> in range 1-12.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
