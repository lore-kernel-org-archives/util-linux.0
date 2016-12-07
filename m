Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32993 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbcLGTpr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Dec 2016 14:45:47 -0500
Received: by mail-ua0-f195.google.com with SMTP id 20so40360700uak.0
        for <util-linux@vger.kernel.org>; Wed, 07 Dec 2016 11:45:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1477427661-19788-1-git-send-email-halfline@gmail.com>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com>
From: Ray Strode <halfline@gmail.com>
Date: Wed, 7 Dec 2016 14:45:26 -0500
Message-ID: <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on
 systemd systems
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Ray Strode <rstrode@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On Tue, Oct 25, 2016 at 4:34 PM, Ray Strode <halfline@gmail.com> wrote:
> From: Ray Strode <rstrode@redhat.com>
>
> If the user is using a systemd system, then its useful to grab the
> environment from the systemd user manager process.
>
> This allows administrators to initialize the environment of the sessions
> via systemd configuration.

Any news on this?

--Ray
