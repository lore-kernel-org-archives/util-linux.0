Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF0C433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 13:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbiDKNsW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbiDKNsN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 09:48:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DE14087
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 06:45:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17B8C1F7AD;
        Mon, 11 Apr 2022 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649684753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUcr3JwRXB9TkR8S+COsk4oENwmucRuci1Xu+evfdcQ=;
        b=PCkjUVMv701W/VPcps1b676bJvlIV9O26XvxDf2nlJS6dIgpxJ0dZzBNddDRbt3sWcV0Y/
        cyNqSOxIrSBoR0oTyVbtfQMgaBsPUxAQuHHBG1LCNmZe1DN3WS0eVCAT762YbwBfe718Ag
        U2YStT2ErWc1Q3qEUKa5hD5+g4EKPVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649684753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUcr3JwRXB9TkR8S+COsk4oENwmucRuci1Xu+evfdcQ=;
        b=N2ZSgQmKvB04sAZFVL65pc54TvKpfmuDTF+UayR3LUxTSWsmOC9M2PCzd+JeUuQIkgsJEx
        lIFeL/FLQtjLX8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0EB713A93;
        Mon, 11 Apr 2022 13:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dy8PKRAxVGIOOgAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Mon, 11 Apr 2022 13:45:52 +0000
Message-ID: <7609d7ad-b9fb-7977-8f22-3bdef2b2c950@suse.cz>
Date:   Mon, 11 Apr 2022 15:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: libuuid related tasks for next v2.39
Content-Language: en-US
To:     "Trapp, Michael" <michael.trapp@sap.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Cc:     Karel Zak <kzak@redhat.com>
References: <20220401092104.b2snvmahp56zturm@ws.net.home>
 <AM9PR02MB70447FD1C9D326ABAF7ABFE8F9E69@AM9PR02MB7044.eurprd02.prod.outlook.com>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <AM9PR02MB70447FD1C9D326ABAF7ABFE8F9E69@AM9PR02MB7044.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dne 07. 04. 22 v 10:23 Trapp, Michael napsal(a):
> For uuidd this would result in:
> -no need for a lock on LIBUUID_CLOCK_FILE, what also might help to 
> solve some authorization issues.
This should be a benefit.

The only possible downside would be losing of context on uuidd restart. 
That happens e. g. during a security update.Could this be a problem? 
Really fast machines restart in a small fraction of second.

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

