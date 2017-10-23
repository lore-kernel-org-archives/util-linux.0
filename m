Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f175.google.com ([209.85.161.175]:46876 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdJWPOd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Oct 2017 11:14:33 -0400
Received: by mail-yw0-f175.google.com with SMTP id t71so12327927ywc.3
        for <util-linux@vger.kernel.org>; Mon, 23 Oct 2017 08:14:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home>
References: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
 <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home>
From: Jeff Sadowski <jeff.sadowski@gmail.com>
Date: Mon, 23 Oct 2017 09:14:31 -0600
Message-ID: <CAM9ceLgCuBD6JE+qWGF=wfPwnnU_Cn91P5Yg=1EKuAC5zPQygw@mail.gmail.com>
Subject: Re: wall logging or run command each post?
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One of the reasons I added this request:

My default desktop is XFCE and it uses gnome-terminals. I don't get
wall messages in gnome-terminals and I wanted a simple way to get wall
messages to my screen I was thinking about using notify-send

On Mon, Oct 23, 2017 at 4:53 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Oct 18, 2017 at 02:06:25PM -0600, Jeff Sadowski wrote:
>> I would like to know if this feature is built into wall or is there a
>> good work around?
>
> wall is usually used by superuser. I guess if you can all "wall" than
> you can also call for example logger to write to the system logs. I
> don't see reason to merge functionally of these tools together.
>
>> I would like to configure wall to run a script after anything is posted to wall.
>
> Why? Maybe there is better way go get your goal.
>
>> I would also like to log all wall messages. I could easily do that
>> with a script.
>
> yes, script(1) is the right way
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
