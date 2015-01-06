Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:65310 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbAFKel (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Jan 2015 05:34:41 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so28937270wgh.22
        for <util-linux@vger.kernel.org>; Tue, 06 Jan 2015 02:34:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
References: <CAO7R9g8opv3Z3aW73xJ-d3ZBwi5_f4td9Xeqk=QBUCqz13fGhw@mail.gmail.com>
	<1420490268.1408121.209893057.48A620D9@webmail.messagingengine.com>
Date: Tue, 6 Jan 2015 11:34:40 +0100
Message-ID: <CAO7R9g8aGM48RzU-ed-cYyAdUEPbX7B4QSsVTdLx90poPtKwhQ@mail.gmail.com>
Subject: Re: questions on util-linux translation
From: Antonio Ceballos <aceballos@gmail.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Benno,

Nice to see you here too. :)

1. Understood. I think I read too quickly the second line for --version.

2. My first suggestion is "too neutral" for that context. Your
suggestion probably sounds better. I presume that something
more explicit but longer is worse, such as:

"partition #7 cannot be removed, as it doesn't exist"

Antonio


On Mon, Jan 5, 2015 at 9:37 PM, Benno Schulenberg
<bensberg@justemail.net> wrote:
>
> Hi Antonio,  :)
>
> On Mon, Jan 5, 2015, at 11:11, Antonio Ceballos wrote:
>> msgid ""
>> " -V, --verbose      explain what is being done;\n"
>> "                      specifying -V more than once will cause a dry-run\n"
>>
>> msgid ""
>> " -V, --version      display version information and exit;\n"
>> "                      -V as --version must be the only option\n"
>>
>> You can see '-V' (uppercase) for both --verbose and --version. Is that correct?
>
> It is.  As the second line for --version tries to explain, -V *only* means
> --version when no other option is specified.  -V together with other options
> means --verbose.
>
>> 2. Could the English wording be improved in the following sentence?
>> msgid "%s: partition #%d already doesn't exist\n"
>
> Hmm, yes, it should.  In Dutch I have translated it to the equivalent
> of "partition #%d doesn't even exist" -- which sounds a tiny bit like:
> "you're stupid".  So I'd better change that.  :|
>
>> I would suggest something like:
>> msgid "%s: partition #%d doesn't exist\n"
>> msgid "%s: partition #%d no longer exists\n"
>
> The latter one does not seem correct -- maybe the partition never
> existed at all.  The verbose message was introduced with commit
> ab025087f91b66ee8e23a16bc49eb0d9bd421d65 -- when a range of
> partitions is specified for removal, say 5 to 9, and partition 7
> does not exist, then, when --verbose is specified, partx would
> mention that "partition #7 already doesn't exist".  Probably it is
> better so say something like "skipping nonexistent partition #7"?
> What do you think?
>
> Benno
>
> --
> http://www.fastmail.com - Faster than the air-speed velocity of an
>                           unladen european swallow
>
