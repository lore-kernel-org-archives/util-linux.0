Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13CCC43381
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C5F2339D
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 14:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbhATOwh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbhATOrC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 Jan 2021 09:47:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E8C061575
        for <util-linux@vger.kernel.org>; Wed, 20 Jan 2021 06:46:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h7so5187390lfc.6
        for <util-linux@vger.kernel.org>; Wed, 20 Jan 2021 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mTPeB+t9ttVqYhhrQsu6J/++7HErpgMqsuNx1YcHGg=;
        b=t95UKoxEAE1gMD0JedYiQYPRt/HPAKhN9ekfDuTJTNMLnmDK8fe6exP1vNJ5sNLmMy
         vjp+zqRgsGlOHhTScSRkzGfdtHdyDLZj2a+VhVt6Tm8Vyd450UkITpDRQ8IOqXQZ0Wik
         mO997jPRul8og1P5jUkuU98OmEgph8At6QZZTKtcFnEPUuVFJncbmSQMD7ujEhiJWqbD
         bSF+Zqu/wGMMYJhdsK+4PJzgtgbOurATGW1XN5lUXLWVwjXtfQebk1R0MHSjoMPDE1VK
         6WKjxTJ2Nj7VXu2hkqzGgHDoD8870cG1saG1uBh7UBcD3X3nlccg6ZhjvGg+0S8Cne6q
         ZG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mTPeB+t9ttVqYhhrQsu6J/++7HErpgMqsuNx1YcHGg=;
        b=Zzu3hwydXbcRASWCjBhztcL4oKFxDY/cCUldgfdAUgpsO3dK/IkHccIQ38uTyYP8gG
         YbpHn+EyVbDENKbfYP8itdcln8DtSvdKhGKDtTHLuB+eq4a53EuX4bHFqGeGiSIPFXMO
         bMGcfcBna1lvykE90pEpAlNjIbdZu+wNcnhR/JP+90wbkJkS/WfDXXJjdFg1l/Te32kg
         L6RhhfZAR6eVq4os8n37G0C+VE/6i+ZnklSzWf7/qzhU9UTXs8KMsv2dOotJYVxRjj4/
         xF0vtg0K5Qf5qc/WdT1M4qT8yoxXKITVBNNIIEv0IxF5ZMHYS8osye+O7DJAhxcM82lR
         OwTg==
X-Gm-Message-State: AOAM532y4xWTbwy8sel+BcMTmhq/Z7q0qqYokIlWT9SKw/YBPuIIlAGw
        sP1zxr7C728sK+gFuSnhVfDzJRlBt7bz7oEWeLxxBQ==
X-Google-Smtp-Source: ABdhPJwgnTJQ4WFaFZHa6rn30ZVyrudqSBiG8zFW6MuATbzf6Sr0H1+3ktc0bKcrsjzZ/wTqRLhPRtLu9sbe0u+M8Iw=
X-Received: by 2002:a19:810:: with SMTP id 16mr4391237lfi.233.1611153979531;
 Wed, 20 Jan 2021 06:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20210116190940.2320819-1-qais.yousef@arm.com> <20210116190940.2320819-4-qais.yousef@arm.com>
In-Reply-To: <20210116190940.2320819-4-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jan 2021 15:46:07 +0100
Message-ID: <CAKfTPtAKBUmvXAnDSyp1-S=uXewQus-HzEaNhpOieRHS1p-tqQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] uclampset: Add man page
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, 16 Jan 2021 at 20:11, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  schedutils/uclampset.1 | 169 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 schedutils/uclampset.1
>
> diff --git a/schedutils/uclampset.1 b/schedutils/uclampset.1
> new file mode 100644
> index 000000000..1a525458a
> --- /dev/null
> +++ b/schedutils/uclampset.1
> @@ -0,0 +1,169 @@
> +.\" uclampset(1) manpage
> +.\"
> +.\" Copyright (C) 2020 Qais Yousef <qais.yousef@arm.com>
> +.\" Copyright (C) 2020 Arm Ltd
> +.\"
> +.\" This is free documentation; you can redistribute it and/or
> +.\" modify it under the terms of the GNU General Public License,
> +.\" version 2, as published by the Free Software Foundation.
> +.\"
> +.\" The GNU General Public License's references to "object code"
> +.\" and "executables" are to be interpreted as the output of any
> +.\" document formatting or typesetting system, including
> +.\" intermediate and printed output.
> +.\"
> +.\" This manual is distributed in the hope that it will be useful,
> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +.\" GNU General Public License for more details.
> +.\"
> +.\" You should have received a copy of the GNU General Public License along
> +.\" with this program; if not, write to the Free Software Foundation, Inc.,
> +.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +.\"
> +.TH UCLAMPSET 1 "August 2020" "util-linux" "User Commands"
> +.SH NAME
> +uclampset \- manipulate the utilization clamping attributes of the system or
> +a process.
> +.SH SYNOPSIS
> +.B uclampset
> +[options]
> +.RI [ -m\ uclamp_min ]\ [ -M\ uclamp_max ]\ command\  [ argument ...]
> +.br
> +.B uclampset
> +[options]
> +.RI [ -m\ uclamp_min ]\ [ -M\ uclamp_max ]
> +.B \-p
> +.RI pid
> +.SH DESCRIPTION
> +.B uclampset
> +sets or retrieves the utilization clamping attributes of an existing \fIpid\fR,
> +or runs \fIcommand\fR with the given attributes.
> +
> +Utilization clamping is a new feature added in v5.3. It gives a hint to the
> +scheduler about the allowed range of utilization the task should be operating
> +at.
> +
> +The utilization of the task affects frequency selection and task placement.
> +Only schedutil cpufreq governor understands handling util clamp hints at the
> +time of writing. Consult your kernel docs for further info about other
> +cpufreq governors support.
> +
> +If you're running on asymmetric heterogeneous system like Arm's big.LITTLE.
> +Utilization clamping can help bias task placement. If the task is boosted such
> +that
> +.BR util_min
> +value is higher than the little cores' capacity, then the scheduler will do its
> +best to place it on a big core.
> +
> +Similarly, if
> +.BR util_max
> +is smaller than or equal the capacity of the little cores, then the scheduler
> +can still choose to place it there even if the actual utilization of the task
> +is at max.
> +
> +Setting a task's
> +.B uclamp_min
> +to a none zero value  will effectively boost the task as when it runs it'll
> +always start from this utilization value.
> +
> +By setting a task's
> +.B uclamp_max
> +below 1024, this will effectively cap the task as when it runs it'll never be
> +able to go above this utilization value.
> +
> +The full utilization range is: [0:1024].
> +
> +.SH OPTIONS
> +.TP
> +.BR \-m
> +Set util_min value.
> +.TP
> +.BR \-M
> +Set util_max value.
> +.TP
> +.BR \-a ,\  \-\-all-tasks
> +Set or retrieve the utilization clamping attributes of all the tasks (threads)
> +for a given PID.
> +.TP
> +.BR \-s ,\  \-\-system
> +Set or retrieve the system-wide utilization clamping attributes.
> +.TP
> +.BR \-\-max
> +Show minimum and maximum valid utilization values, then exit.
> +.TP
> +.BR \-p ,\  \-\-pid
> +Operate on an existing PID and do not launch a new task.
> +.TP
> +.BR \-v ,\  \-\-verbose
> +Show status information.
> +.TP
> +.BR \-V ,\  \-\-version
> +Display version information and exit.
> +.TP
> +.BR \-h ,\  \-\-help
> +Display help text and exit.
> +.SH USAGE
> +.TP
> +The default behavior is to run a new command:
> +.B uclampset
> +.I [-m\ uclamp_min]
> +.I [-M\ uclamp_max]
> +.IR command\  [ arguments ]
> +.TP
> +You can also retrieve the utilization clamping attributes of an existing task:
> +.B uclampset \-p
> +.I pid
> +.TP
> +Or set them:
> +.B uclampset \-p
> +.I pid
> +.I [-m\ uclamp_min]
> +.I [-M\ uclamp_max]
> +.TP
> +Or control the system-wide attributes:
> +.B uclampset \-s
> +.I [-m\ uclamp_min]
> +.I [-M\ uclamp_max]
> +.SH PERMISSIONS
> +A user must possess
> +.B CAP_SYS_NICE
> +to change the scheduling attributes of a process.  Any user can retrieve the
> +scheduling information.
> +
> +.SH NOTES
> +The system wide utilization clamp attributes are there to control the _allowed_
> +range the tasks can use. By default both
> +.BR uclamp_min
> +and
> +.BR uclamp_max
> +are set to 1024. This means users can set the utilization clamp values for
> +their task across the full range [0:1024].
> +
> +.TP
> +For example:
> +.B uclampset \-s
> +.I -m\ 512
> +.I -M\ 700
> +.PP
> +will prevent any task from being boosted higher than 512. And all tasks in the

will prevent any task from being boosted higher than 700
or
will ensure  any task to be boosted higher than 512


> +systems are capped to a utilization of 700. Effectively rendering the maximum
> +performance of the system to 700.
> +
> +Consult your kernel docs for the exact expected behavior on that kernel.
> +.SH AUTHORS
> +.UR qais.yousef@arm.com
> +Qais Yousef
> +.UE
> +.SH SEE ALSO
> +.BR nice (1),
> +.BR renice (1),
> +.BR taskset (1),
> +.BR sched (7)
> +.sp
> +See
> +.BR sched_setscheduler (2)
> +for a description of the Linux scheduling scheme.
> +.SH AVAILABILITY
> +The uclampset command is part of the util-linux package and is available from
> +https://www.kernel.org/pub/linux/utils/util-linux/.
> --
> 2.25.1
>
