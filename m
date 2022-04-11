Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF261C433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 13:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbiDKNiU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbiDKNiS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 09:38:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA561CFCD
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 06:36:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCE3C1F38D;
        Mon, 11 Apr 2022 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649684161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EjCfQu39OzffTGFgE8Z/PfUUNxbMsI9DT5rOsHK2B8=;
        b=iF1C8n1OzCBk1HBhms139srW3rT24GNwXh+lnhLhGk6ue9F8ohT1XDFM6sIglCNyH43H0c
        uSlkHs90VK4LhNQV7zc3RQbPs/IBb2l0Xtla1Mz8NCgeJeODlcGjZ02ARs10zCd8Il7Czh
        /knZIs8nTaMr8Hhh0KQGYlbAca8BKZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649684161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EjCfQu39OzffTGFgE8Z/PfUUNxbMsI9DT5rOsHK2B8=;
        b=7B2x0dJI2Vc5N6M3CaFSxI21NpDej8EzFN15bERYtdqRbCc3GdxtzzWNSCSSIccnvoaqxO
        jFszb/ClsKBDnYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A654613A93;
        Mon, 11 Apr 2022 13:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5Z0GJsEuVGJxNQAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Mon, 11 Apr 2022 13:36:01 +0000
Message-ID: <dbf20375-8af0-5f33-7d14-f22b7d73e6b4@suse.cz>
Date:   Mon, 11 Apr 2022 15:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: libuuid related tasks for next v2.39
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc:     "Trapp, Michael" <michael.trapp@sap.com>
References: <20220401092104.b2snvmahp56zturm@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20220401092104.b2snvmahp56zturm@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dne 01. 04. 22 v 11:21 Karel Zak napsal(a):
>
>   Hi,
>
>   I'd like to invest time to libuuid and uuidd in the next v2.39.
>
>   Stanislav had same ideas and a lot of research in libuuid code to
>   make things more stable, and I'd like to improve testability of the
>   all UUID stack we have in util-linux.
>
>   TODO:
>
>    * uuid_generate_* functions refactoring to make things readable and
>      to separate ways how UUIDs are generated
Yes, it makes sense.
>    * clean up uuidd to generate UUID only by the most robust UUIDs way
>      without any fallback (use uuid_generate_time_sync_by_file())
Yes.
>    * report all issues on uuidd stderr
Yes. Or even exit with error on any (potentially permanent) issue.

But more important:

All issues should generate error to the libuuid. Otherwise the 
application gets downgraded unsafe UUIDs without properly detecting it.

>    * optionally keep clockfile (/var/lib/libuuid/clock.txt) in uuidd hands
>      to make sure the file is not shared with other users if the system
>      is only-uuidd based; for example add --clock-file uuidd option to
>      overwrite libuuid default.
I guess it is mandatory, otherwise we will have a problem of the root 
stealing of the lock file.

The proposed default was ~/.libuuid_clock.txt

There should be an internal function that sets the path to the clock 
file. It probably makes sense to make the path configurable in the 
config file, but the function should not be public:
- Only uuidd and the configuration read will use the function.
- Applications on systems systems without writable home could configure 
it e. g. to /run.
- Using different paths for different applications would cause bad 
things; private function makes it impossible.
- It will ensure that nothing else than uuidd will use 
/var/lib/libuuid/clock.txt.

I have applied a temporary work-around for the root stealing problem:

uuidd.service:

ExecStartPre=+-/usr/bin/chown uuidd:uuidd /var/lib/libuuid/clock.txt

But it is ugly and it cures just a symptoms and does not work with older version of systemd.

>    * invite our SAP friends to the upstream development to share ideas
>      and requirement :-)
>
>    * rewrite misc-utils/test_uuidd.c to something commonly usable
>      (uuidinfo tool?) and use it in util-linux regression tests,
>      features:
>
>       - detect if uuidd is running
>       - add statistics to the uuidd (number of generated UUIDs,
>         clients, errors, ...)
>       - add new UUIDD_OP_* to the uuidd to get additional information
>         about the daemon (paths, statistics, etc.)
>       - stress test (like the current test_uuidd.c)
>
>
>    * anything else?
>
Add support for three levels of safe state for uuid_generate_time_safe():
- Absolutely safe (uuidd was used, and there was no error in uuidd). The 
UUID is guaranteed to be unique.
- Safe for the current UID (clock file was used, but no uuidd). The UUID 
is guaranteed to be unique for the current UID, but there is no 
guarantee that other UIDs.
- Unsafe (clock file use failed, uuidd use failed). The UUID is not 
guaranteed to be unique at all. Just a random.

It opens a discussion whether the new return value should be integrated 
to the current functions, or add a new function with three return 
values. Or even change the current function to the macro, so the newly 
compiled code will stop to use the old function name.

If we will change the API, then no code will fail. But the result will 
depend on the check implementation:
If the return value will be compared by == -1, it will catch only the 
unsafe return.
If the return value will be compared by != 0, it will catch both unsafe 
and current-UID-safe.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

