Return-Path: <SRS0=qEjn=NR=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA92C32789
	for <util-linux@archiver.kernel.org>; Tue,  6 Nov 2018 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB272085B
	for <util-linux@archiver.kernel.org>; Tue,  6 Nov 2018 12:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB272085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbeKFV7F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:59:05 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36402
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729711AbeKFV7F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Nov 2018 16:59:05 -0500
X-IronPort-AV: E=Sophos;i="5.54,471,1534802400"; 
   d="scan'208";a="284505650"
Received: from unknown (HELO function) ([193.50.110.184])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2018 13:34:03 +0100
Received: from samy by function with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gK0YU-00042K-TA; Tue, 06 Nov 2018 13:34:02 +0100
Date:   Tue, 6 Nov 2018 13:34:02 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.33
Message-ID: <20181106123402.cy52t2ql4yvfqme6@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lychnacc4fl5b4nb"
Content-Disposition: inline
In-Reply-To: <20181106113306.hd2qcvbde22cxur6@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--lychnacc4fl5b4nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Karel Zak, le mar. 06 nov. 2018 12:33:06 +0100, a ecrit:
> The util-linux release v2.33 is available at
> 
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33
> 
> Feedback and bug reports, as always, are welcomed.

It seems new portability issues came in since the rc I tested :)
Fix attached.

Samuel

--lychnacc4fl5b4nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix

Index: util-linux-2.33/term-utils/agetty.c
===================================================================
--- util-linux-2.33.orig/term-utils/agetty.c
+++ util-linux-2.33/term-utils/agetty.c
@@ -1768,6 +1768,7 @@ static void eval_issue_file(struct issue
 }
 #else /* ISSUE_SUPPORT */
 
+#ifdef AGETTY_RELOAD
 static int issue_is_changed(struct issue *ie)
 {
 	if (ie->mem_old && ie->mem
@@ -1780,6 +1781,7 @@ static int issue_is_changed(struct issue
 
 	return 1;
 }
+#endif
 
 static void print_issue_file(struct issue *ie,
 			     struct options *op,
@@ -2066,8 +2068,8 @@ static char *get_logname(struct issue *i
 		/* Write issue file and prompt */
 		do_prompt(ie, op, tp);
 
-#ifdef AGETTY_RELOAD
 	no_reload:
+#ifdef AGETTY_RELOAD
 		if (!wait_for_term_input(STDIN_FILENO)) {
 			/* refresh prompt -- discard input data, clear terminal
 			 * and call do_prompt() again
@@ -2731,6 +2733,7 @@ static void output_special_char(struct i
 			fprintf (ie->output, "%d ", users);
 		break;
 	}
+#if defined(RTMGRP_IPV4_IFADDR) && defined(RTMGRP_IPV6_IFADDR)
 	case '4':
 	case '6':
 	{
@@ -2754,6 +2757,7 @@ static void output_special_char(struct i
 			netlink_groups |= RTMGRP_IPV6_IFADDR;
 		break;
 	}
+#endif
 	default:
 		putchar(c);
 		break;

--lychnacc4fl5b4nb--
