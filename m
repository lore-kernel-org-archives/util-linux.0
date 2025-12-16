Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9F3370FF
	for <util-linux@vger.kernel.org>; Tue, 16 Dec 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927313; cv=none; b=VKyyAQj3QJrDdp61WicgYMlLJJYqZKLYVgkZb73a59TarXV1h0NEI/TITBtdvFlFT8fP6dj8WDANeEnbdDkPxE0vrkZeb4AolPQH+2TQr/OkjA2d22KYmfmET2JbI91cOiuZXcWJUiDs3ZePBcIesK61gKabwmMTMysQuQCxO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927313; c=relaxed/simple;
	bh=89AyTsbWXHZ5FKP1CKny+p3SyffzX4Nc5t5orXFOHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUK6639GS1p1YZy7By3H0YQ4XX9/83KUrHlnChybRS19C6QOVnB5WytckN6UEizkcsHn7Ve8gzWzb476B7fN144R22BPE0qlvfPtKaZ+Fm+3gS8phOH8/xrUOG6Mc5a4MQLptnnZm262cxZ1YUi7AwMG587H08E8k5GpRLDeeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=iOZ1474m; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="iOZ1474m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1765927309; bh=89AyTsbWXHZ5FKP1CKny+p3SyffzX4Nc5t5orXFOHrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOZ1474mE5jLBWjtW0q9bIKWlQtHQkn3+7QLCSH6izkSSSmyRAc2MHH3wozKqcmsA
	 W90+SYOUzJQVV0XAfRaSyrWO+pAHm+ENanIMtPPMr6JYbuRRFgvelKVi+q+rOBZVWN
	 nSi3052LcBGxShWIfcS41mnRLbM3f3LBS878U104=
Date: Wed, 17 Dec 2025 00:21:42 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Kiran <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Message-ID: <9dc90e33-30e2-48c3-8602-00fce280f9ef@t-8ch.de>
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
 <20251214010108.29535-1-kiranrangoon0@gmail.com>
 <5a20c5ee-b56c-472e-94a2-c7223c281b3e@t-8ch.de>
 <CA+uoJ5sE0uLwidR5_5+BZP3fS=ObYbWHsNQv+k8Na5aWL3ZwDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+uoJ5sE0uLwidR5_5+BZP3fS=ObYbWHsNQv+k8Na5aWL3ZwDg@mail.gmail.com>

Hi Kiran,

please reply in-line to each individual comment instead of top-posting a
single reply. It keeps the conversation understandable.

On 2025-12-16 15:40:10-0500, Kiran wrote:
> Yes I could work on this. I'll change pre-Unix-epoch v1/v6 UUID
> timestamps to be treated as an error. uuid_time_v1() and
> uuid_time_v6() will detect underflow, return failure, and
> __uuid_time() will propagate it by returning -1 and setting tv_sec =
> tv_usec = -1, unless you have any objections.

Looking at this more closely: __uuid_time() is directly exposed to users
of libuuid as uuid_time(). This means that any change of the function's
contract would break all external users and should be avoided at all
costs. Fortunately it turns out that the timestamps embedded in UUIDs
only use 60 bits. This means that the calculation can be performed in an
int64_t without any risk of over- or underflow. Please try to implement
it that way instead. It might be useful to change the signature of
gregorian_to_unix() to
"static void gregorian_to_unix(uint64_t ts, struct timeval *tv)".
Also please perform each logical step in a dedicated commit.


Thomas

> On Tue, Dec 16, 2025 at 8:08 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2025-12-13 20:01:08-0500, Kiran Rangoon wrote:
> > > gregorian_to_unix now returns -1 and sets errno=EOVERFLOW
> > > for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
> > > now use signed arithmetic to prevent unsigned wraparound.
> > >
> > > This fixes uuidparse displaying far-future dates for historical UUIDs.
> > >
> > > The regression test has been updated to show actual result instead of hardcoded wrong
> > > date.
> >
> > Thanks!
> >
> > >
> > > Example output:
> > >     $ ./build/uuidparse bf2eb110-d788-1003-aa59-ce1e9e293641
> > > Before:
> > >     60041-08-13 16:41:36,271592-04:00
> > > After:
> > >     1969-12-31 19:00:00,000000-05:00
> > >
> > > Handling negative timestamps gracefully would require broader changes,
> > > so I’ve kept this patch focused on preventing pre-1970 wraparound.
> >
> > IMO we should to this properly. Is this something you want to work on?
> >
> > > Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
> > > ---
> > >  libuuid/src/uuid_time.c       | 15 +++++++++++----
> > >  tests/expected/uuid/uuidparse |  2 +-
> > >  2 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
> > > index c7516152b..f0d2c8f36 100644
> > > --- a/libuuid/src/uuid_time.c
> > > +++ b/libuuid/src/uuid_time.c
> > > @@ -60,15 +60,22 @@
> > >  /* prototype to make compiler happy */
> > >  time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
> > >
> > > -static uint64_t gregorian_to_unix(uint64_t ts)
> > > +static int64_t gregorian_to_unix(uint64_t ts)
> > >  {
> > > -     return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
> > > +    const uint64_t offset = 0x01B21DD213814000ULL;
> > > +
> > > +    if (ts < offset) {
> > > +        errno = EOVERFLOW;
> > > +        return -1;
> >
> > The callers do not check for errors. Instead this gets converted to the
> > epoch only by chance.
> >
> > > +    }
> > > +
> > > +    return ts - offset;
> > >  }
> > >
> > >  static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
> > >  {
> > >       uint32_t high;
> > > -     uint64_t clock_reg;
> > > +     int64_t clock_reg;
> > >
> > >       high = uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) << 16);
> > >       clock_reg = uuid->time_low | ((uint64_t) high << 32);
> > > @@ -80,7 +87,7 @@ static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
> > >
> > >  static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
> > >  {
> > > -     uint64_t clock_reg;
> > > +     int64_t clock_reg;
> > >
> > >       clock_reg = uuid->time_low;
> > >       clock_reg <<= 16;
> > > diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
> > > index 9edb05e4e..0f521a760 100644
> > > --- a/tests/expected/uuid/uuidparse
> > > +++ b/tests/expected/uuid/uuidparse
> > > @@ -11,7 +11,7 @@ UUID                                  VARIANT   TYPE       TIME
> > >  00000000-0000-3000-8000-000000000000  DCE       name-based
> > >  00000000-0000-4000-8000-000000000000  DCE       random
> > >  00000000-0000-5000-8000-000000000000  DCE       sha1-based
> > > -00000000-0000-6000-8000-000000000000  DCE       time-v6    60038-03-11 05:36:10,955161+00:00
> > > +00000000-0000-6000-8000-000000000000  DCE       time-v6    1970-01-01 00:00:00,000000+00:00
> >
> > If it is an error, the output should be empty.
> >
> > >  00000000-0000-0000-d000-000000000000  Microsoft
> > >  00000000-0000-1000-d000-000000000000  Microsoft
> > >  00000000-0000-2000-d000-000000000000  Microsoft
> > > --
> > > 2.47.3
> 
