Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC729AB11
	for <util-linux@vger.kernel.org>; Sun, 28 Dec 2025 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766911667; cv=none; b=SijZWyEVfehoN9WRTRg7NGLvRhD5ALNg5wfax2i3WfNy4C/y3bLZ4iq9++TeZflyFzhXHRfA7JdyTvw9JUt2/7giuDUhxa4wBWK0ntxsHueJSNJ/S93gq0hDBkSIhqwSkkucgatsZ9d71J6ThBmK9koM93xiO+L7VVqrJeYMj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766911667; c=relaxed/simple;
	bh=aOWlqM2DmZRN20FfH0yftvbr0HFdw8kBtogqVCj9kic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebI//Cmf62rBueKHTJKVf7q1EsczEyu07jXv43hBzvurCYHu/TPz+cDnvAV+rjS6sDZ7+igujGALC3+1kjp5oA5iw6QxPU3d6bnlj5NkQC6Xzg215syVXrqoc6+Y5W5lZQo09yujTNSMr4wI6++N0IthGNdjOlqq6Njp2x2Ifs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=przqaAI+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="przqaAI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1766911654; bh=aOWlqM2DmZRN20FfH0yftvbr0HFdw8kBtogqVCj9kic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=przqaAI+ALNdThwpgVPSUCwiv+V6GcAmrhA6yGMIlFudstZsQjtErvy0F2Eav7z/x
	 D2SDRqUE+TqRRNfso4I2wOI7xxz7lXGp3m5tAvairsxnBTgghBAQhUsr/kGqEX9szE
	 0hr2IsBrj5Rm2T17jRtS5Drd5fScCVzZjNXiZoos=
Date: Sun, 28 Dec 2025 09:47:34 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/4] libuuid: Fix pre-1970 UUID timestamp overflow
Message-ID: <01132cca-5044-4b5f-96c5-9f4e8ce1df42@t-8ch.de>
References: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
 <20251223180055.2396-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223180055.2396-1-kiranrangoon0@gmail.com>

Hi Kiran,

On 2025-12-23 13:00:51-0500, Kiran Rangoon wrote:

(...)

> Kiran Rangoon (4):
>   libuuid: simplify gregorian-to-unix offset calculation
>   libuuid: refactor gregorian_to_unix to populate timeval directly
>   libuuid: fix timestamp overflow for pre-1970 dates
>   tests: correct UUID timestamp test expectations
> 
>  libuuid/src/uuid_time.c       | 15 +++++++--------
>  tests/expected/uuid/uuidparse |  5 ++++-
>  tests/ts/uuid/uuidparse       |  3 +++
>  3 files changed, 14 insertions(+), 9 deletions(-)

The series can't be applied as is. There are two 'PATCH 1/4' and  the
'In-Reply-To' headers are broken. How did you send the patches?
Please just use 'git send-email' or 'b4' [0].
Also don't make your v5 a reply to the v4, it makes things messy.
Just start a new thread.


Thomas

[0] https://b4.docs.kernel.org/en/latest/
