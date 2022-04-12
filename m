Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00066C43219
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbiDLMaU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353183AbiDLM1x (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 08:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03BE6F4
        for <util-linux@vger.kernel.org>; Tue, 12 Apr 2022 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649763381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CKK5a9jF+p54WBmLJ8RY5HlJyLuhSC9n7ybn+BFubtI=;
        b=SKwFVVK2kLZbijYM2FsKZ9SwWCT/l7WlEoyoYJ2cSE2kNOSk9yBTYyRASA1Yb/dIgIk6gh
        xxBllqPQAdAhfp38g93WbSkOwiMc0limhKsJZ9P4C03fbc22IfkoASoYQW8l49vlbeYuXw
        PzluKWrxorZdiRQ4hZ7sSzFRiXWBzss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-TvGBc3x3Or6KAbXHa4Kzow-1; Tue, 12 Apr 2022 07:36:17 -0400
X-MC-Unique: TvGBc3x3Or6KAbXHa4Kzow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60B6C811E76;
        Tue, 12 Apr 2022 11:36:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8DD1145BEE0;
        Tue, 12 Apr 2022 11:36:16 +0000 (UTC)
Date:   Tue, 12 Apr 2022 13:36:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org,
        "Trapp, Michael" <michael.trapp@sap.com>
Subject: Re: libuuid related tasks for next v2.39
Message-ID: <20220412113614.varb4mnyyojovu6s@ws.net.home>
References: <20220401092104.b2snvmahp56zturm@ws.net.home>
 <dbf20375-8af0-5f33-7d14-f22b7d73e6b4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf20375-8af0-5f33-7d14-f22b7d73e6b4@suse.cz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 11, 2022 at 03:36:01PM +0200, Stanislav Brabec wrote:
> Dne 01. 04. 22 v 11:21 Karel Zak napsal(a):
> >    * uuid_generate_* functions refactoring to make things readable and
> >      to separate ways how UUIDs are generated
> Yes, it makes sense.
> >    * clean up uuidd to generate UUID only by the most robust UUIDs way
> >      without any fallback (use uuid_generate_time_sync_by_file())
> Yes.
> >    * report all issues on uuidd stderr
> Yes. Or even exit with error on any (potentially permanent) issue.
> 
> But more important:
> 
> All issues should generate error to the libuuid. Otherwise the application
> gets downgraded unsafe UUIDs without properly detecting it.
 
Yes.

> >    * optionally keep clockfile (/var/lib/libuuid/clock.txt) in uuidd hands
> >      to make sure the file is not shared with other users if the system
> >      is only-uuidd based; for example add --clock-file uuidd option to
> >      overwrite libuuid default.
> I guess it is mandatory, otherwise we will have a problem of the root
> stealing of the lock file.
> 
> The proposed default was ~/.libuuid_clock.txt
> 
> There should be an internal function that sets the path to the clock file.
> It probably makes sense to make the path configurable in the config file,
> but the function should not be public:
>
> - Only uuidd and the configuration read will use the function.
> - Applications on systems systems without writable home could configure it
> e. g. to /run.
> - Using different paths for different applications would cause bad things;
> private function makes it impossible.

I can imagine this as public :-) The majority of users will use basic
simple API (just give me UUID). The advanced minority has to read docs
:-)

I can imagine use-case where you have more independent users who need
time based UUIDs, but they don't care about collisions with the other
users (for example two web applications with independent DBs, etc.)/

The default should be safe as much as possible, but we should not try
to be more smart than admins/developers as we have no clue about their
use-cases ;-)

But this is not so important for now, we can keep it as uuidd only
in UUIDD_PRIVATE namespace in libuuid/src/libuuid.sym.

> - It will ensure that nothing else than uuidd will use
> /var/lib/libuuid/clock.txt.
> 
> I have applied a temporary work-around for the root stealing problem:
> 
> uuidd.service:
> 
> ExecStartPre=+-/usr/bin/chown uuidd:uuidd /var/lib/libuuid/clock.txt
> 
> But it is ugly and it cures just a symptoms and does not work with older version of systemd.
> 
> >    * invite our SAP friends to the upstream development to share ideas
> >      and requirement :-)
> > 
> >    * rewrite misc-utils/test_uuidd.c to something commonly usable
> >      (uuidinfo tool?) and use it in util-linux regression tests,
> >      features:
> > 
> >       - detect if uuidd is running
> >       - add statistics to the uuidd (number of generated UUIDs,
> >         clients, errors, ...)
> >       - add new UUIDD_OP_* to the uuidd to get additional information
> >         about the daemon (paths, statistics, etc.)
> >       - stress test (like the current test_uuidd.c)
> > 
> > 
> >    * anything else?
> > 
> Add support for three levels of safe state for uuid_generate_time_safe():
> - Absolutely safe (uuidd was used, and there was no error in uuidd). The
> UUID is guaranteed to be unique.
> - Safe for the current UID (clock file was used, but no uuidd). The UUID is
> guaranteed to be unique for the current UID, but there is no guarantee that
> other UIDs.
> - Unsafe (clock file use failed, uuidd use failed). The UUID is not
> guaranteed to be unique at all. Just a random.
> 
> It opens a discussion whether the new return value should be integrated to
> the current functions, or add a new function with three return values. Or
> even change the current function to the macro, so the newly compiled code
> will stop to use the old function name.
> 
> If we will change the API, then no code will fail. But the result will
> depend on the check implementation:
> If the return value will be compared by == -1, it will catch only the unsafe
> return.
> If the return value will be compared by != 0, it will catch both unsafe and
> current-UID-safe.

If we decide to change the API (introduce a new functions) then I'd like to 
see something based on handler/context. IMHO only context/handler based libraries
are extendible and easy to maintain and ready for relatively complex tasks.

    libuuid_context *cxt = uuid_new_context();

    uuid_context_set_clockfile(cxt, "/somewhere/clock.txt");

    uuid_context_generate_time(cxt, &uuid, &state);

where @state is UUID_STATE_{SAFE,UNSAFE,UUIDD,...}

we can also add

    uuid_context_force_state(cxt, UUID_STATE_ABSOLUTE);

to make sure uuid_context_generate_time() returns only requested
quality or error, etc.

We can also for uuidd make locking optional:

    uuid_context_disable_lock(cxt, TRUE);

etc.

We can also use the context for communication with uuidd

    uuid_uuidd *uuidd = uuid_new_uuidd();

    uuid_uuidd_get_state()
    uuid_uuidd_get_pid()
    uuid_uuidd_get_statistic()
    uuid_uuidd_get_clockfile()
    uuid_uuidd_get_error()

    uuid_uuidd_get_uuid()
    ....


Anyway, the first step we need uuid_generate_* functions
refactoring to clean up the spaghetti stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

