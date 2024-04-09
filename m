Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6F1EB46
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654160; cv=none; b=H+22AKhwc1/uAFZ9r/vJ0fF2Cj3ZkKctSqiax6fhxcvYygSUzIkXrzGiBLZJrriUdJz0z/4xP/Vp/cGQzOxAhhxVsePhOI7yAREANip2S7go0Gob5A7NMaVtq/sw3jqw2DOJ+F54QKCnM8RoZq0rrNznVtEqjGPjFqZcBB0wa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654160; c=relaxed/simple;
	bh=6lgmjF7PBD1xYODKyiWDJkHVIuF0tnDR0ZSukvCFTQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/mmWQ11sHHJbXPMCapFYg7mgINLezNf/mVunds9NpktPSN92WyB/rSaaL3OZlFrkLYsCXNK5I5NvSAGugDXAh+3Cr8lKYS3EMmclDk7AWBZmKWgRFIxNaM0SJOKBF7puuTU4Kh2qBnLJgWpXVk4pB8XZrEcrD5m8ZE1wwDUE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=VLA0tuX7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="VLA0tuX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1712654156; bh=6lgmjF7PBD1xYODKyiWDJkHVIuF0tnDR0ZSukvCFTQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLA0tuX7V5gBzX3IaZNTbKO7cJx7/GDv3Z8ya7P2M3bK60F7HvQfSk5Fte+jKBvQ7
	 v3nuY+RAnL2f5M49oL44Hy1h9pUSyaYMhksjhYEyiGRUnoWBbwJwqpBjT+zzNq4XJS
	 FK3k3koUO0aLa1NsmgIvPdrHiQGGFRhEfl+xstuY=
Date: Tue, 9 Apr 2024 11:15:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: logger/{errors,formats} tests fail on 32-bit PowerPC
Message-ID: <95d76e15-e879-4f6d-a7e3-c44ee948511e@t-8ch.de>
References: <afef1b770ad80d50660bb2c53a0a8330b88d1049.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afef1b770ad80d50660bb2c53a0a8330b88d1049.camel@physik.fu-berlin.de>

Hi,

On 2024-04-09 09:26:39+0200, John Paul Adrian Glaubitz wrote:
> the following two tests are failing on 32-bit PowerPC with 2.40:
> 
> ---------------------------------------------------------------------
>   2 tests of 312 FAILED
> 
>       logger/errors
>       logger/formats
> ---------------------------------------------------------------------
> 
> The diffs seem to be related to timestamps:

Thanks for the report.

Could you test https://github.com/util-linux/util-linux/pull/2938 ?
(The last commit is enough)

> diff-{{{
> --- /<<PKGBUILDDIR>>/tests/expected/logger/errors-rfc5424_exceed_size.err	2024-01-31 10:02:15.794809649 +0000
> +++ /<<PKGBUILDDIR>>/tests/output/logger/errors-rfc5424_exceed_size.err	2024-04-08 15:12:24.205336645 +0000
> @@ -1 +1 @@
> -<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424_exceed_size - - [timeQuality tzKnown="1" isSynced="0"] abc
> +<13>1 2009-02-13T23:31:30.000000+00:00 test-hostname rfc5424_exceed_size - - [timeQuality tzKnown="1" isSynced="0"] abc
> }}}-diff
> 
> Details can be found in the full build log in [1].
> 
> Adrian
> 
> > [1] https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=powerpc&ver=2.40-5&stamp=1712589234&raw=0
