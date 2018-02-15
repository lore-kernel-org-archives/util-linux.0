Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.32-rc1
Date: Thu, 15 Feb 2018 13:46:56 +0100
Cc: util-linux@vger.kernel.org
References: <20180213123132.jlhfn4z4ijtanjgc@ws.net.home>
In-Reply-To: <20180213123132.jlhfn4z4ijtanjgc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201802151346.56864.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 13 February 2018, Karel Zak wrote:
> The util-linux release v2.32-rc1 is available at
>
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.32/
>
> Feedback and bug reports, as always, are welcomed.

Just one minor thing. Couldn't we remove the .gz tarballs nowadays? IMO 
it's standard now to have xz available. Coreutils only provides .xz 
since 2011 (which was maybe too early).

Though keeping the .gz files doesn't hurt much, somehow I always feel 
disturbed about these duplicated tar balls. The download page would 
look a bit cleaner and "tar -xf ..." tab completion works better when 
only one tarball available :)

cu,
RUdi
