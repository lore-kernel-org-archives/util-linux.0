Return-Path: me@mmalecki.com
MIME-Version: 1.0
In-Reply-To: <20140303090438.GB2783@x2.net.home>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
	<1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
	<CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
	<5310B80C.7000205@ubuntu.com>
	<1393612047.2899.31.camel@buesod1.americas.hpqcorp.net>
	<5310E100.5020405@ubuntu.com>
	<20140303090438.GB2783@x2.net.home>
Date: Mon, 3 Mar 2014 22:19:13 +0100
Message-ID: <CAKC8-7yzVUYCkO3L+omT3fsQ3q-Tj-VJkeu77LcR+ie6tJ0kog@mail.gmail.com>
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
From: =?ISO-8859-2?Q?Maciej_Ma=B3ecki?= <me@mmalecki.com>
To: Karel Zak <kzak@redhat.com>
Cc: Phillip Susi <psusi@ubuntu.com>, Davidlohr Bueso <davidlohr@hp.com>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

I just sent out fixed patches, but for some reason they went to the
main list (I think I needed `git send-email --thread`). Sorry for
that.

Now `fdisk` binary falls back to retrying
`fdisk_context_assign_device` with `readonly == 1` and warns user
about it.

On Mon, Mar 3, 2014 at 10:04 AM, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Feb 28, 2014 at 02:18:24PM -0500, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 2/28/2014 1:27 PM, Davidlohr Bueso wrote:
>> >> You really want to tell the user that they aren't going to be
>> >> able to write up front.
>> >
>> > Sure why not, just not in a library! You can do this in the fdisk
>> > program. And if Karel doesn't agree and wants to apply this patch
>> > anyway, then it should *at least* be in DBG context.
>>
>> Right, which is what I said just after that ;)
>
>  I'll try to improve the function after libfdisk branch merge into
>  master branch (this or next week). The current code is probably
>  really not optimal.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
