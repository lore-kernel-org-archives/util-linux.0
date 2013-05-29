Return-Path: mail@bernhard-voelker.de
Message-ID: <51A5D07E.8000603@bernhard-voelker.de>
Date: Wed, 29 May 2013 11:55:10 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        10317@debbugs.gnu.org
Subject: Re: su: -l and -p should not be used together
References: <519DF601.4090700@bernhard-voelker.de> <20130529094010.GF30341@x2.net.home>
In-Reply-To: <20130529094010.GF30341@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On 05/29/2013 11:40 AM, Karel Zak wrote:
> diff --git a/login-utils/su-common.c b/login-utils/su-common.c
> index ba2a616..a41d015 100644
> --- a/login-utils/su-common.c
> +++ b/login-utils/su-common.c
> @@ -810,6 +810,11 @@ su_main (int argc, char **argv, int mode)
>        ++optind;
>      }
>  
> +  if (simulate_login && !change_environment) {
> +    warnx(_("ignore --preserve-environment, it's mutually exclusive to --login."));
> +    change_environment = true;
> +  }
> +

thanks.

As the change was in su-common.c, this also affects runuser.
I think this should then be documented in runuser.1, too, right?

Have a nice day,
Berny
