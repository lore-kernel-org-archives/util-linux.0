Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753514D2BF
	for <util-linux@vger.kernel.org>; Thu, 25 Apr 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060314; cv=none; b=aEK2ua4xgRdhLSzndpClmobTGCGgkNvfhlRmqHC28hJpHA4hsAdaI6jNvLjM6sdLLM9j7cADggMiKHQSsNaLokYgH7iK5vKto+NoKhZ8922v1tg/ZFsQOkC7AViSFMrwlZoAL7zl1uZ9wcMtPghzB7IS1NpVkOJ1mD0hW6zMPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060314; c=relaxed/simple;
	bh=1IgEA90EZAi5YRp5hP4ohk9vwTBnbT/hU5hRI7RPFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryA5Zqcu3cRQdMR+RJU4fRPu8jJtgPCz56NCRLZWvvWNaSsfrg440sp53Mj/FFUWpLwc4wzp1zCaSRCZzFma7KvFpClJxIaG0hizpFF1nBb64LZDX1OYqZlrVqrDta7tghRSJV+At92kaYoGd0tGNTJdh3xenV2XgbeinqKzOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=lGaPhXQz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="lGaPhXQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1714060308; bh=1IgEA90EZAi5YRp5hP4ohk9vwTBnbT/hU5hRI7RPFjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGaPhXQzRqOgB1k92hDExFhRxFV8i96+uk14pPjleKyPsvYXbjMki5dFbcA84GH7u
	 0qddtD65aKIauzJ6C5z5Wapyn9Ga4md6znBB9Z4gGW7pjLRiS7A4qpKTcnYpXcijwh
	 PfsgNPF5w5rIG9m/4cx2T48aCEajFgmWgTyQ8zJY=
Date: Thu, 25 Apr 2024 17:51:47 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, 
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v11] coresched: Manage core scheduling cookies for tasks
Message-ID: <295323c3-a43a-4f60-9c71-3b38a19b1d6f@t-8ch.de>
References: <20240423111251.367023-1-thijs@raymakers.nl>
 <20240425153627.120762-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425153627.120762-1-thijs@raymakers.nl>

Hi,

On 2024-04-25 17:36:26+0000, Thijs Raymakers wrote:
> Co-authored-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> ---
> 
> I noticed that the CI pipeline failed because the coresched test reported
> a "No such device" error.
> 
> https://download.copr.fedorainfracloud.org/results/packit/util-linux-util-linux-2990/fedora-rawhide-x86_64/07343926-util-linux/builder-live.log.gz
> 
> This happens because the following check in the kernel's
> kernel/sched/core_sched.c fails:
> 
> > /* Called from prctl interface: PR_SCHED_CORE */
> > int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
> > 			 unsigned long uaddr)
> > {
> >   [snip]
> > 
> > 	if (!static_branch_likely(&sched_smt_present))
> > 		return -ENODEV;
> 
> The prctl call will return ENODEV whenever SMT is not available,
> but the kernel is compiled with CONFIG_SCHED_CORE. I've added a check that skips
> the tests for coresched when this is the case.
> 
> Thijs
> 
> 
> Interdiff against v10:
>   diff --git a/schedutils/coresched.c b/schedutils/coresched.c
>   index 7bc5c9d38..beeb01702 100644
>   --- a/schedutils/coresched.c
>   +++ b/schedutils/coresched.c
>   @@ -328,7 +328,7 @@ int main(int argc, char **argv)
>    
>    	if (!is_core_sched_supported())
>    		errx(EXIT_FAILURE,
>   -		     _("No support for core scheduling found. Does your kernel"
>   +		     _("No support for core scheduling found. Does your kernel "
>    		       "support CONFIG_SCHED_CORE?"));
>    
>    	sched_core_cookie cookie;
>   diff --git a/tests/ts/schedutils/coresched b/tests/ts/schedutils/coresched
>   index e34fa319f..debb8cbfc 100755
>   --- a/tests/ts/schedutils/coresched
>   +++ b/tests/ts/schedutils/coresched
>   @@ -22,6 +22,12 @@ if [[ $CORESCHED_TEST_KERNEL_SUPPORT_CMD == *"CONFIG_SCHED_CORE"* ]]; then
>      ts_skip "Kernel has no CONFIG_SCHED_CORE support"
>    fi
>    
>   +# Kernel and the machine must support SMT
>   +CORESCHED_HAS_SMT_SUPPORT=$(</sys/devices/system/cpu/smt/control)
>   +if [[ "$CORESCHED_HAS_SMT_SUPPORT" != "on" ]]; then
>   +  ts_skip "SMT is unavailable (state: $CORESCHED_HAS_SMT_SUPPORT)"
>   +fi
>   +
>    # The output of coresched contains PIDs and core scheduling cookies, both of which should be
>    # assumed to be random values as we have no control over them. The tests replace these values
>    # with sed before writing them to the output file, so it can match the expected output file.
> 
>  .gitignore                                    |   1 +
>  bash-completion/coresched                     |   0
>  configure.ac                                  |  12 +-
>  meson.build                                   |  16 +-
>  meson_options.txt                             |   2 +-
>  schedutils/Makemodule.am                      |   8 +
>  schedutils/coresched.1.adoc                   | 139 +++++++
>  schedutils/coresched.c                        | 358 ++++++++++++++++++
>  tests/commands.sh                             |   1 +
>  .../coresched-copy-from-child-to-parent       |   1 +
>  ...coresched-copy-from-parent-to-nested-child |   1 +
>  .../schedutils/coresched-get-cookie-own-pid   |   1 +
>  .../coresched-get-cookie-parent-pid           |   1 +
>  .../coresched-new-child-with-new-cookie       |   1 +
>  .../coresched-set-cookie-parent-pid.err       |   1 +
>  .../expected/schedutils/set-cookie-parent-pid |   1 +
>  tests/ts/schedutils/coresched                 |  89 +++++
>  17 files changed, 627 insertions(+), 6 deletions(-)
>  create mode 100644 bash-completion/coresched
>  create mode 100644 schedutils/coresched.1.adoc
>  create mode 100644 schedutils/coresched.c
>  create mode 100644 tests/expected/schedutils/coresched-copy-from-child-to-parent
>  create mode 100644 tests/expected/schedutils/coresched-copy-from-parent-to-nested-child
>  create mode 100644 tests/expected/schedutils/coresched-get-cookie-own-pid
>  create mode 100644 tests/expected/schedutils/coresched-get-cookie-parent-pid
>  create mode 100644 tests/expected/schedutils/coresched-new-child-with-new-cookie
>  create mode 100644 tests/expected/schedutils/coresched-set-cookie-parent-pid.err
>  create mode 100644 tests/expected/schedutils/set-cookie-parent-pid
>  create mode 100755 tests/ts/schedutils/coresched

[..]

> +// If PR_SCHED_CORE is not recognized, or not supported on this system,
> +// then prctl will set errno to EINVAL. Assuming all other operands of
> +// prctl are valid, we can use errno==EINVAL as a check to see whether
> +// core scheduling is available on this system.
> +static bool is_core_sched_supported(void)
> +{
> +	sched_core_cookie cookie = 0;
> +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, getpid(),
> +		  PR_SCHED_CORE_SCOPE_THREAD, &cookie))
> +		if (errno == EINVAL)
> +			return false;

IMO the ENODEV should be handled here.
So the user can get a proper error message.

This would then also remove the need for another ts_skip in the
testcase.

> +
> +	return true;
> +}
> +

[..]
