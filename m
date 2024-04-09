Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CE12FF97
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670300; cv=none; b=bCyhH19wXaaKEgbaB1zvx+LQhLPVG1Cahu41RKa8YxCY3N77b+uah48/Vpsl5hW+IcYpFwp1CqkHBgarhk90w5na3KtQRDeCp9EOIvcKykMqVnD7ZWufstRRSJwpM9cfm0eV4WzFJ3uNOmhLWnri0V09N9NmHrCRJkXI1KqlcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670300; c=relaxed/simple;
	bh=eA4+HugTXPW/XRDvlkFartHX5RuIiScGHmryBrTaIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2sf4su3F0WonxxHZkl4pwVWPSltWEWR5U+V9yWkNra6cUVaVKvY+i+g4EIWEESEoCCUNeTd5Wf8eWsV8MI6Tx4c/484tv2WYSnGQpJdK8podqHWis4fovZtHrI7T6vCAVRxEI5JfMJmNIW0o0uj0RSnwD55anrQzbhYmEM2XtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfgEk0fe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfgEk0fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712670297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtERljnXESKdWiKlwU19YCT98Hp/7mJ/97mVudlR7Pk=;
	b=NfgEk0feOuoI02HipZCgojmUkZU8ye9JMMVi/kJ3Gh87CbNFoAjQ/6Hdnfw4G4rGHdFRw8
	OEBfZhRmXT1qkrAwY2+w2KYjBOTzvUqkHbcgyiT2rHHPVL4z3Cwzj5jBQ6RrqRxFbgQL1e
	7nKKMfqlLHu5OugHGNCI8ni34Le4f6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-nHvVjE0QOqKhQR_Y5JMFiQ-1; Tue, 09 Apr 2024 09:44:53 -0400
X-MC-Unique: nHvVjE0QOqKhQR_Y5JMFiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79A7C188ACA0;
	Tue,  9 Apr 2024 13:44:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A53E940B4979;
	Tue,  9 Apr 2024 13:44:52 +0000 (UTC)
Date: Tue, 9 Apr 2024 15:44:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: thomas@t-8ch.de, pauld@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH v6] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240409134430.twndleg7rxnfsf4m@ws.net.home>
References: <763a3030-d1c1-4701-b8bb-6878e7b4e18e@t-8ch.de>
 <20240409115532.18762-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409115532.18762-1-thijs@raymakers.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


 Hi,

sorry for delay in my review ...

On Tue, Apr 09, 2024 at 01:55:32PM +0200, Thijs Raymakers wrote:
> +== OPTIONS
> +*-p*, *--pid* _PID_::
> +Operate on an existing PID and do not launch a new task.

"Nnot launch a new task" does not seem to be true, as you later
provide an example:

  Copy the cookie from a task with pid _123_ to a new task _command_{colon}::
  *{command} --copy -p* _123_ \-- _command_ [_argument_...]

> +*-d*, *--dest* _PID_::
> +When using *--copy*, specify a destination PID where you want to copy the cookie to.

I find it a little confusing that the --pid is sometimes used as a
source and in other cases as a destination.

     coresched --new --pid 123              # pid is destination
     coresched --copy --pid 123 --dest 456  # pid is source

It seems --copy always requires a source PID (according to the man
page), why not require a PID as argument for --copy:

    coresched --copy 123 --pid 456

in this way --pid will be always destination (for 'copy' and 'new'
functions) and you will not need extra --dest option at all.

If you want to keep the basic functions (e.g. --copy) without
arguments, it would be better to have --source, --dest, and
--dest-type instead of using the ambiguous --pid.

I can also imagine the basic "functions" without "--".

    coresched [get] [--dest] 123
    coresched copy [--source] 123 [--dest] 456
    coresched new [--dest] 456

In my opinion, we do not have to strictly adhere to old taskset or
similar commands.

It should be noted that command line arguments are crucial, as they
are difficult to modify after release.

> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/prctl.h>
> +#include <unistd.h>
> +
> +#include "c.h"
> +#include "closestream.h"
> +#include "nls.h"
> +#include "optutils.h"
> +#include "strutils.h"
> +
> +// These definitions might not be defined in the header files, even if the
> +// prctl interface in the kernel accepts them as valid.
> +#ifndef PR_SCHED_CORE
> +#define PR_SCHED_CORE 62
> +#endif

pedantic note, use extra space within ifdef

#ifndef PR_SCHED_CORE
# define PR_SCHED_CORE 62
#endif

please :-)

> +static void core_sched_push_cookie(pid_t to, sched_core_scope type)
> +{
> +	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, to, type, 0))
> +		err(EXIT_FAILURE, _("Failed to push cookie to PID %d"), to);
> +}
> +
> +static void core_sched_copy_cookie(pid_t from, pid_t to,
> +				   sched_core_scope to_type)
> +{
> +	core_sched_pull_cookie(from);
> +	core_sched_push_cookie(to, to_type);
> +
> +	if (sched_core_verbose) {
> +		sched_core_cookie before = core_sched_get_cookie(from);
> +		fprintf(stderr,
> +			_("%s: copied cookie 0x%lx from PID %d to PID %d\n"),
> +			program_invocation_short_name, before, from, to);

 Don't use fprintf(), use:

        warnx(_(copied cookie 0x%lx from PID %d to PID %d\n"), before, from, to);

> +static void core_sched_get_and_print_cookie(pid_t pid)
> +{
> +	if (sched_core_verbose) {
> +		sched_core_cookie after = core_sched_get_cookie(pid);
> +		fprintf(stderr, _("%s: set cookie of PID %d to 0x%lx\n"),
> +			program_invocation_short_name, pid, after);
> +	}

 warnx()

> +int main(int argc, char **argv)
> +{
> +	struct args args = { 0 };
> +	args.cmd = SCHED_CORE_CMD_GET;
> +	args.type = PR_SCHED_CORE_SCOPE_THREAD_GROUP;

 struct args args = {
        .cmd = SCHED_CORE_CMD_GET,
        .type = PR_SCHED_CORE_SCOPE_THREAD_GROUP
 };

 (the rest is set to zero by compiler).

> +ts_check_test_command "$TS_CMD_CORESCHED"
> +ts_check_test_command "tee"
> +ts_check_test_command "sed"

ts_check_test_command is for in-tree stuff, use

    ts_check_prog "tee"
    ts_check_prog "sed"

for things in $PATH.

> +ts_init_subtest "get-own-pid-with-cookie"
> +$TS_CMD_CORESCHED -p $$ 2>> "$TS_ERRLOG" | sed "s/$$/OWN_PID/g" | sed "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"

 Let's save some forks, execute sed(1) only once:

    | sed -e "s/$$/OWN_PID/g" \
          -e "s/$CORESCHED_COOKIE/COOKIE/g" >> "$TS_OUTPUT"

> +ts_finalize_subtest
> +
> +ts_init_subtest "spawn-child-with-new-cookie"
> +$TS_CMD_CORESCHED -n -- "$TS_CMD_CORESCHED" 2>> "$TS_ERRLOG" \
> +  | sed 's/^.*\(0x.*$\)/\1/g' \
> +  | sed "s/$CORESCHED_COOKIE/SAME_COOKIE/g" \
> +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
> +ts_finalize_subtest

  | sed -e ... -e ... -e 

> +ts_init_subtest "change-cookie-of-parent"
> +$TS_CMD_CORESCHED -n -- /bin/bash -c "$TS_CMD_CORESCHED -c -p \$\$ -d $$"
> +$TS_CMD_CORESCHED -p $$ 2>> "$TS_ERRLOG" \
> +  | sed "s/$$/OWN_PID/g" \
> +  | sed "s/$CORESCHED_COOKIE/COOKIE/g" \
> +  | sed "s/0x.*$/DIFFERENT_COOKIE/g" >> "$TS_OUTPUT"
> +ts_finalize_subtest

  | sed -e ... -e ... -e 


Looks good, thanks for all the work!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

