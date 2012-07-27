Return-Path: mail@bernhard-voelker.de
Message-ID: <501271D2.8090708@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 12:47:46 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
References: <20120727081033.GA14019@x2.net.home> <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com> <20120727103132.GA28708@x2.net.home>
In-Reply-To: <20120727103132.GA28708@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 07/27/2012 12:31 PM, Karel Zak wrote:
>  Maybe, but many of the tests requires root permissions and it's
>  designed for developers only. I'd like to avoid situations when the
>  tests are executed with root permissions by automatic distro build
>  systems etc.

Why? The more folks run the tests, the more bugs can be reported and fixed.
What's wrong about the tests? And if there's something wrong: shouldn't
they not be made more robust?

E.g. coreutils also has many tests which "require_root", and I think
it's safe to run these tests.

Have a nice day,
Berny
