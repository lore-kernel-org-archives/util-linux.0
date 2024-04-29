Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0D129A9A
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413150; cv=none; b=LxD8w9R+uDkCAmPhewP3rKYreEuaKBtlSsmRpv40Z6syJ5v36lUIXR1sl5CSjAVlflXe5+g9uIevZZ8dORrX6MSBbtosv6dB8FL6fSPxo7WkXRro+4CkTrhBsNPhs+Bf1EXpuIFy1JxDLaOrCcctTfJFV9+rVNh5bUqKLsHxvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413150; c=relaxed/simple;
	bh=8zIoqa30pycfyVZVP+T8weMzp6eNaOpBK3/n70J73O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDuDS94oBp6fFKBeycbo/GjbrOSMQwqKQoO72fQPhuA35Zoo9TCPBtpm/lOiHsURv73CsqgXCow7/qo/8/sLxk8SGqVI6Cj+c1xHXew9wulYxoSKu1u0INGT1GXzNHRh62AKNPuG69ROJu99dgAFx0xiO02BVR1SSDFjt4JdIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=U7Neb/7C; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="U7Neb/7C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pk5i51WTQQSJZHmdErGhhEu7aNu8GUWIGw7iaX0Cpkk=; b=U7Neb/7Ca8TrbXzlGb/1tAB3Gc
	9PWVLosaBB15SHcK1d/MS8dA/TndpErM85YOdQXQXbI3N3L01zN/p5KNwSE5kIc5w6RpqoYlbGr33
	gHBXvy577iDo1+2+cZh5eYvMOCfn9O2J/wvw9uTLl0rxCfW2cnKyGPtDsd9ReujZeAX9Y6D2Ky2wb
	78o20XlaXJRnJuPi6iKorGZqOYf82zyyS5eiQBkixmieq+KFsyOr5mOFr1CbH4EWLHLnRVy24DPAs
	Fslu7HSshi9AdTNzW9MyHOk3rQ/9idQ5zUWexzUgMJghrK2C6Vu2hFGSYvnAOdxoWGROg42h9S1WS
	WdMxzkDA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1s1VAw-005EaA-Uz; Mon, 29 Apr 2024 17:52:26 +0000
Date: Mon, 29 Apr 2024 19:52:24 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Michael Biebl <biebl@debian.org>, 1070019@bugs.debian.org
Subject: Re: [Pkg-utopia-maintainers] Bug#1070019: udisks2: autopkgtest
 failure: fsconfig system call failed: /dev/sr1: Can't open blockdev
Message-ID: <tv7dqc5xtyddf5momgpf5m6zg3gmuzgpps32e5a5pdmupfo2ed@26bxmjjvn3sk>
References: <171432120653.1819175.3886447797776800472.reportbug@per>
 <9625ca13-a775-4768-b4f1-b2da4de70009@debian.org>
 <ngnnmq6rsi6ohuipejqw4ussgtbur3nab5nnvx3vqrfhlrvfvk@67u5ihxjhcri>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ngnnmq6rsi6ohuipejqw4ussgtbur3nab5nnvx3vqrfhlrvfvk@67u5ihxjhcri>
X-Debian-User: zeha

* Chris Hofstaedtler <zeha@debian.org> [240429 15:24]:
> > udisks2's autopkgtest fails when tried together with util-linux 2.40. An
> > example can be seen here:
> > https://ci.debian.net/packages/u/udisks2/testing/amd64/46012968/
> > 
> > 537s ======================================================================
> > 537s FAIL: test_ext4 (__main__.FS.test_ext4)
> > 537s fs: ext4
> > 537s ----------------------------------------------------------------------
> > 537s Traceback (most recent call last):
> > 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 1107, in _do_udisks_check
> > 537s     cd_fs.call_mount_sync(ro_options, None)
> > 537s gi.repository.GLib.GError: udisks-error-quark: GDBus.Error:org.freedesktop.UDisks2.Error.Failed: Error mounting /dev/sr1 at /media/root/41b1acb1-744c-422a-9071-2dba5368a683: fsconfig system call failed: /dev/sr1: Can't open blockdev (0)
> > 537s
> > 537s During handling of the above exception, another exception occurred:
> > 537s
> > 537s Traceback (most recent call last):
> > 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 725, in test_ext4
> > 537s     self._do_fs_check('ext4')
> > 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 894, in _do_fs_check
> > 537s     self._do_udisks_check(fs_type)
> > 537s   File "/tmp/autopkgtest.btnhgm/build.cz4/src/src/tests/integration-test", line 1112, in _do_udisks_check
> > 537s     self.fail('Mounting read-only device with \'rw\' option failed'
> > 537s AssertionError: Mounting read-only device with 'rw' option failedwith an unexpected error.
> > 537s Got: udisks-error-quark: GDBus.Error:org.freedesktop.UDisks2.Error.Failed: Error mounting /dev/sr1 at /media/root/41b1acb1-744c-422a-9071-2dba5368a683: fsconfig system call failed: /dev/sr1: Can't open blockdev (0)
> > 537s Expected: 'is write-protected but explicit read-write mode requested' or 'is write-protected but `rw' option given'
 

> I won't get to it this week (also re: stable v2.40.1), but maybe
> someone else has seen this failure already?

Having said that, it seems likely the test was broken by this
change in util-linux:
  libmount: report kernel message from new API
  https://github.com/util-linux/util-linux/commit/9da5644e414cdc318f0311260dabc6035c85b58e

I don't know if the error messages are supposed to be stable or not,
but it looks like a very intentional change :-)

Orthogonally, "/dev/sr1: Can't open blockdev" seems not very
informative if it's supposed to mean "write-protected but `rw'
option given".

Chris

