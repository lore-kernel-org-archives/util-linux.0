Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170419113444.qfgmhgocuavp43id@ws.net.home>
References: <20170419113444.qfgmhgocuavp43id@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 19 Apr 2017 13:35:45 +0100
Message-ID: <CAG27Bk3GdEUDCGvi4Cn0q2JodDV+G82daHZOY9H9pXx4E4X5OA@mail.gmail.com>
Subject: Re: column --table based on libsmartcols
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 19 April 2017 at 12:34, Karel Zak <kzak@redhat.com> wrote:
>  Overkill or useful? ;-)

Looks very useful.

The only Wish List item I can think of is --number-table-columns
option that would print something like

$ echo a b c | column -t  --number-table-columns-header-and-tail
1 2 3
a b c
1 2 3

In itself that is totally pointless rubbish line, but quite often I'm
looking some tabular data and I know field number 'eh large' is the
field I am interested - but afaik there is no tool that will tell me
these numbers easily. Perhaps some awk END for i {1 ... NF} could do
the same if adding this wish crosses a overkill line.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
