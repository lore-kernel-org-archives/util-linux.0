Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk3GdEUDCGvi4Cn0q2JodDV+G82daHZOY9H9pXx4E4X5OA@mail.gmail.com>
References: <20170419113444.qfgmhgocuavp43id@ws.net.home> <CAG27Bk3GdEUDCGvi4Cn0q2JodDV+G82daHZOY9H9pXx4E4X5OA@mail.gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 22 Apr 2017 22:52:47 +0100
Message-ID: <CAG27Bk3wmsMLAi7RG3ZO2kfSR9=nCEXzfv1BSGGz8WFmua44WQ@mail.gmail.com>
Subject: Re: column --table based on libsmartcols
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 19 April 2017 at 13:35, Sami Kerola <kerolasa@iki.fi> wrote:
> On 19 April 2017 at 12:34, Karel Zak <kzak@redhat.com> wrote:
>>  Overkill or useful? ;-)
>
> Looks very useful.
>
> The only Wish List item I can think of is --number-table-columns
> option that would print something like
>
> $ echo a b c | column -t  --number-table-columns-header-and-tail
> 1 2 3
> a b c
> 1 2 3
>
> In itself that is totally pointless rubbish line, but quite often I'm
> looking some tabular data and I know field number 'eh large' is the
> field I am interested - but afaik there is no tool that will tell me
> these numbers easily. Perhaps some awk END for i {1 ... NF} could do
> the same if adding this wish crosses a overkill line.

I played for a while with column[1] from your branch. Manual page
examples should include a version of the last example sent to mail
list.

$ column /proc/self/mountinfo \
  --table-columns=ID,PARENT,MAJMIN,ROOT,TARGET,VFS-OPTS,PROP,SEP,TYPE,SOURCE,FS-OPTS
\
  --table-hide=SOURCE,MAJMIN,ROOT,PROP,SEP,TYPE,VFS-OPTS,FS-OPTS \
  --table-order=TARGET,ID,PARENT \
  --tree TARGET --tree-id ID --tree-parent PARENT

With that small improvement (and rebase on top of latest origin/master)
I would say this change set is ready to be merged.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
