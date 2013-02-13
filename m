Return-Path: firebird347@gmail.com
MIME-Version: 1.0
Sender: firebird347@gmail.com
In-Reply-To: <20130213125339.GC7799@x2.net.home>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
 <1360218141-4463-3-git-send-email-cmaloney@theoreticalchaos.com> <20130213125339.GC7799@x2.net.home>
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Wed, 13 Feb 2013 13:33:47 -0700
Message-ID: <CA+K3q6q12R+a7BH3gcm+NdpPjzA+fjMVraDK02Mx9FWHffuk-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] chsh-chfn: Move pam auth to its own function,
 factoring out common code
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Miloslav Trmac <mitr@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 13, 2013 at 5:53 AM, Karel Zak <kzak@redhat.com> wrote:
>
>  what happen if REQUIRE_PASSWORD is not defined?
>
>     Karel

The file will still be compiled (and linked against) PAM and the code
path operates as it did previously. This does make it simple though if
someone wants to remove the dependency of PAM / compile without it.

Cody
