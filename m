Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170418102305.pfzvyukxj5fb6wsx@ws.net.home>
References: <20170414203948.12295-1-kerolasa@iki.fi> <20170418102305.pfzvyukxj5fb6wsx@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 19 Apr 2017 19:11:57 +0100
Message-ID: <CAG27Bk1iUXNAhc2Ene2h-9=RC4BLn0VK6q_JV_dJKe9Cc-iqsg@mail.gmail.com>
Subject: Re: [PATCH] scriptreplay: determine if script --quiet was used to
 create typescript
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>, Rui Zhao <renyuneyun@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 18 April 2017 at 11:23, Karel Zak <kzak@redhat.com> wrote:

> Anyway, I don't like officially supported file formats without any
> header. IMHO it would be really nice to add to the typescript:
>
>  ### script(1) typescript; Version: util-linux v2.30; Date: 2017-04-18 12:10:43+0200
>
> ... and maybe more information. The same for timing file.

I agree. What comes to header data it should include header length
in bytes. Something like

### script(1) typescript; Header Length: 104 Version: util-linux
v2.30; Date: 2017-04-18 12:10:43+0200

As long it's easy to know how long to jump rest of the format does
not really matter. Right.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
