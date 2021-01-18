Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD0C433E0
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9750520829
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbhARNHs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:07:48 -0500
Received: from foss.arm.com ([217.140.110.172]:35464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391690AbhARNHf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Jan 2021 08:07:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C635731B;
        Mon, 18 Jan 2021 05:06:44 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0787A3F719;
        Mon, 18 Jan 2021 05:06:43 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:06:41 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 0/5] Add a new uclampset utility
Message-ID: <20210118130641.t6nqi5tv7pagb5e2@e107158-lin>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210116190940.2320819-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 01/16/21 19:09, Qais Yousef wrote:
> Since kernel v5.3 we have a new feature called utilization clamping that allows
> influencing the utilization signals of a task, ultimately influencing the
> performance of these tasks.
> 
> The series adds a new utility called uclampset that allows the user to
> manipulate util clamp (or uclamp for short) for existing running processes or
> when running a new command; in a similar spirit to how taskset and chrt
> currently work.
> 
> Peter/Dietmar/Vincent/Patrick; reviewing the manpage (patch 3) to make sure it
> explains this feature right would be much appreciated.

You can find a branch of the changes in my github too if it helps:

	git clone https://github.com/qais-yousef/util-linux -b uclampset

Thanks

--
Qais Yousef
