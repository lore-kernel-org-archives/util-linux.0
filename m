Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBE5F861
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397060; cv=none; b=mnfpwca2s2IvkeolQO9b8zAUdeVSW8ExQI1RwMFPiXsQpQUShzvoVtDYXDdQZntR5VH2Usrd/FNoPxTOAkyLWkxNlimOgXbZVtJD0L0f5hWm8xV3xSGjBBoBbPxjCtrG62h8QHQXD6O2OepaBTagaszJp8S9AAE+20t/RAUxTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397060; c=relaxed/simple;
	bh=doxVHELHlt1DLlIFP8SmWXQdtszoJrVWt2NBErzNvcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuIMOkUEgi4K/Yq/yzkfkxPFgpiEVCHOsU+rJiYt+gWlAASu/9aZxU8LU32MNkxAQg5WG/TmjOaiiCXoCuTfz4NuReGkQCui2mrhnovxJPECzUfcoyXOCVhUkkFV/V4BmFgGgXmdi7vKqo5TZ6hf3z59pJbn97dUYlnrkpBMBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mfRO+VsU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mfRO+VsU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x3vpu30FNfbya92HHMSEwgruJyL8zx877g7+7seBn8Q=; b=mfRO+VsUXABlDrEU2gV3+9nTT9
	H+IxBg4rMTIIBLoUPIpvwUCPwSYJaB4hseDZP/i993HHQd+RUzb9s4a3Em5oM3EQpT8647qe94ZyF
	Jf0v0jyLIdXtTUlGvMD6eLclT3MR1gI/aE1+nFOlnLORdBe92T0VCvqo/01FO7xxtG7flu3jvrL4z
	U+Y8de/qs6K0jL3gRlWkp4HjvgortIK0B+uiGZ81knO3rUEgWFaMP12NrIki1xHecpXFs5x6viM1I
	TIYoRR2vlPkKA2P2HxjWjQQAoZuyrqRs98zYZtxAoc5eXcIh0s6YNLxeNe2pSmnj9NDgCydMhZMVZ
	G9OeIRFA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1s1Qai-0053OW-Mf; Mon, 29 Apr 2024 12:58:44 +0000
Date: Mon, 29 Apr 2024 14:58:40 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Michael Biebl <biebl@debian.org>, 1070019@bugs.debian.org
Subject: Re: [Pkg-utopia-maintainers] Bug#1070019: udisks2: autopkgtest
 failure: fsconfig system call failed: /dev/sr1: Can't open blockdev
Message-ID: <ngnnmq6rsi6ohuipejqw4ussgtbur3nab5nnvx3vqrfhlrvfvk@67u5ihxjhcri>
References: <171432120653.1819175.3886447797776800472.reportbug@per>
 <9625ca13-a775-4768-b4f1-b2da4de70009@debian.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9625ca13-a775-4768-b4f1-b2da4de70009@debian.org>
X-Debian-User: zeha

Dear util-linux@,

in Debian, udisks2 2.10.1-6 (autopkg-)tests fail with util-linux
2.40, but passed with 2.39. We are not yet sure if this is directly
caused by util-linux, but it seems somewhat likely.

I won't get to it this week (also re: stable v2.40.1), but maybe
someone else has seen this failure already?

> udisks2's autopkgtest fails when tried together with util-linux 2.40. An
> example can be seen here:
> https://ci.debian.net/packages/u/udisks2/testing/amd64/46012968/
> 
> 537s ======================================================================
> 537s FAIL: test_ext4 (__main__.FS.test_ext4)
> 537s fs: ext4
> 537s ----------------------------------------------------------------------
> 537s Traceback (most recent call last):
> 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 1107, in _do_udisks_check
> 537s     cd_fs.call_mount_sync(ro_options, None)
> 537s gi.repository.GLib.GError: udisks-error-quark: GDBus.Error:org.freedesktop.UDisks2.Error.Failed: Error mounting /dev/sr1 at /media/root/41b1acb1-744c-422a-9071-2dba5368a683: fsconfig system call failed: /dev/sr1: Can't open blockdev (0)
> 537s
> 537s During handling of the above exception, another exception occurred:
> 537s
> 537s Traceback (most recent call last):
> 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 725, in test_ext4
> 537s     self._do_fs_check('ext4')
> 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 894, in _do_fs_check
> 537s     self._do_udisks_check(fs_type)
> 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 1112, in _do_udisks_check
> 537s     self.fail('Mounting read-only device with \'rw\' option failed'
> 537s AssertionError: Mounting read-only device with 'rw' option failedwith an unexpected error.
> 537s Got: udisks-error-quark: GDBus.Error:org.freedesktop.UDisks2.Error.Failed: Error mounting /dev/sr1 at /media/root/41b1acb1-744c-422a-9071-2dba5368a683: fsconfig system call failed: /dev/sr1: Can't open blockdev (0)
> 537s Expected: 'is write-protected but explicit read-write mode requested' or 'is write-protected but `rw' option given'
> 
> I do not understand what this error means, or what the underlying problem is.
> Please investigate.

For context, Debian's util-linux 2.40-7 should have everything from
2.40 stable up to a8aa0b5f154a44557f5bae5a4027bdbfe42b0323.

Chris

