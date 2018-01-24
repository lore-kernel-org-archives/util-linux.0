Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 1/2] cal: honor num_months when only a year argument
To: Karel Zak <kzak@redhat.com>
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
 <20180124125418.txntlrwtme7mjqor@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <a18dca0a-7e73-52a4-5c0d-ab5bdd9373b8@gmx.com>
Date: Wed, 24 Jan 2018 10:22:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180124125418.txntlrwtme7mjqor@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 01/24/2018 07:54 AM, Karel Zak wrote:
> On Mon, Jan 22, 2018 at 03:05:08PM -0500, J William Piggott wrote:

8< ...

> We need to add a note to the man page that -y forces cal(1) to use 
> year header in all contexts.
> 
> Comments?

Well, this is a case where I damned if I do and damned if I don't.

In my queue of patches I address this problem. If I submit them all at
once it's a problem for reviewing. If I piecemeal the changes then they
don't make sense. Sometimes I wish that I could present the final result
before submitting any patches.

The year header is currently broken in other contexts as well; it is
better to keep it in the month header as it is for all other output.
Then I repurpose the top header to display the calendar system:
Gregorian, Julian, Mixed. I think this is needed now that we have
multiple options that control which calendar system is being displayed.
You want to add more reform dates in the future which will make showing
which calendar system is displayed all the more relevant.

I'll post my next set and hopefully you will see where I'm going.

Note: the next set is intended to apply on top of these two patches.

> 
>     Karel
> 
