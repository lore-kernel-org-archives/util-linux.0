Return-Path: bruce.dubbs@gmail.com
Subject: Re: fstab format
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <575F3F4C.9020103@gmail.com>
 <20160614083051.2rm5bdksffs6hiei@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <57604B60.3060206@gmail.com>
Date: Tue, 14 Jun 2016 13:22:24 -0500
MIME-Version: 1.0
In-Reply-To: <20160614083051.2rm5bdksffs6hiei@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Jun 13, 2016 at 06:18:36PM -0500, Bruce Dubbs wrote:
>> Does the fstab file support line continuation with a backslash-newline?
>
> No.
>
>> There is no indication in the fstab man page one way or another.  In the
>> case of some entries that use long device IDs like PARTUUID or several
>> options, it would be nice to be able to control the format for easier
>> reading.
>
> Yes, but fstab is de-facto standard file parsed on many many places.
> We cannot change/extend the file format.

I understand.  Thanks.  There are certain other projects that wouldn't 
care about de-facto standards, but I appreciate your position.

   -- Bruce
