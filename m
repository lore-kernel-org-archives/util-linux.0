Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38800 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbaB1QXo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 11:23:44 -0500
Message-ID: <5310B80C.7000205@ubuntu.com>
Date: Fri, 28 Feb 2014 11:23:40 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: =?UTF-8?B?TWFjaWVqIE1hxYJlY2tp?= <me@mmalecki.com>,
        Davidlohr Bueso <davidlohr@hp.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>	<1393554731.2899.15.camel@buesod1.americas.hpqcorp.net> <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
In-Reply-To: <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/28/2014 6:00 AM, Maciej Małecki wrote:
>>> libfdisk/src/context.c | 17 +++++++++++++---- 1 file changed,
>>> 13 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c 
>>> index c405403..40f9080 100644 --- a/libfdisk/src/context.c +++
>>> b/libfdisk/src/context.c @@ -248,17 +248,26 @@ static int
>>> warn_wipe(struct fdisk_context *cxt) int
>>> fdisk_context_assign_device(struct fdisk_context *cxt, const
>>> char *fname, int readonly) { -     int fd; +     int fd, mode;
>>> 
>>> DBG(CONTEXT, dbgprint("assigning device %s", fname)); 
>>> assert(cxt);
>>> 
>>> reset_context(cxt);
>>> 
>>> -     if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC))
>>> < 0) { -             if ((fd = open(fname, O_RDONLY|O_CLOEXEC))
>>> < 0) +retry: +     mode = (readonly ? O_RDONLY : O_RDWR) |
>>> O_CLOEXEC; +     fd = open(fname, mode); +     if (fd < 0) { +
>>> if (readonly) return -errno; -             readonly = 1; +
>>> else { +                     fdisk_warn(cxt, +
>>> _("%s: opening device in read write mode failed"), +
>>> fname); +                     readonly = 1; +
>>> goto retry; +             } }
>> 
>> This is 1) obscenely ugly and 2) not the place for such message.
>> There's no reason to pollute output like this. Why do I care how
>> the device is opened when I'm not going to write anything to it?
>> 
>> The correct way is to do what you do in patch 2, inform the user
>> that the device is only for opened for reading and just skip the
>> write operation.

You really want to tell the user that they aren't going to be able to
write up front.

I have to say this function was already broken.  If the caller
requests write access and that fails, then the call should fail.  It
should *not* automatically fall back to read-only without giving any
indication to the caller.  If the caller wants to retry for read only,
then it can, and print a warning letting the user know it has switched
to ready only.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTELgMAAoJEI5FoCIzSKrwlM0H/iVJLdAPqE3OOgaIJRmk+NC5
uLlMwVMY4zHJakuq4GtxX5rekdy+kLTuVokZjxUTcI2WM9uBJwFXSwd4sPJ2i3C+
47w8tS4FMzP4LKOck60cc61FpAaKaqez9GGQ8zkMNZnt5S6ptCOOoMGtYuqXm1AW
LWYHSbSsmXsTiQIWLEg/GZhBMUaInjcMiVr4nzINXN8CnwJ695Xyold0rnkAHxK0
+FhKNtGuab88GjGosla9kK1Nd2/6rjLt6HqYDBHfZaWkcTzjv4y+OCEz6Am7SFZp
PkrqmWV0FXvUGj8C4RrNf3dSiElorgkPbTS1P1+JRNFLZIAO7YFbapke7MZ4eDg=
=7pzO
-----END PGP SIGNATURE-----
