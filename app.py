import streamlit as st
import requests
from bs4 import BeautifulSoup
import jieba
from collections import Counter
import pandas as pd
from pyecharts import options as opts
from pyecharts.charts import WordCloud, Bar, Pie, Funnel, Line, Scatter, Radar
from streamlit_echarts import st_pyecharts

# 页面配置
st.set_page_config(
    page_title="文本分析可视化工具",
    page_icon="📊",
    layout="wide"
)
# 自定义CSS样式
st.markdown("""
    <style>
    .main {
        background: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
        padding: 2rem;
    }
    .title-container {
        text-align: center;
        padding: 1rem;
        margin-bottom: 2rem;
        background: linear-gradient(to right, #8fd3f4, #84fab0);
        border-radius: 10px;
    }
    .subtitle {
        color: #666;
        text-align: center;
        font-size: 0.9rem;
    }
    .stTextInput {
        margin-top: 2rem;
    }
    </style>
""", unsafe_allow_html=True)

# 标题区域
st.markdown("""
    <div class="title-container">
        <h1>📊 文本分析可视化工具</h1>
        <p class="subtitle">一个强大的文本分析工具，支持多种可视化方式展示文本特征</p>
    </div>
""", unsafe_allow_html=True)

def get_text_content(url):
    """获取网页文本内容"""
    try:
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
        }
        response = requests.get(url, headers=headers)
        response.encoding = 'utf-8'
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # 移除脚本和样式
        for script in soup(["script", "style"]):
            script.decompose()
            
        text = soup.get_text()
        return text.strip()
    except Exception as e:
        st.error(f"获取内容失败: {str(e)}")
        return ""

def process_text(text, min_freq=2):
    """文本分词和统计"""
    # 加载停用词
    with open('stop_words.txt', 'r', encoding='utf-8') as f:
        stop_words = set([line.strip() for line in f])
    
    # 分词并过滤
    words = jieba.cut(text)
    word_freq = Counter(w for w in words if w not in stop_words and len(w) > 1)
    
    # 过滤低频词
    word_freq = {k: v for k, v in word_freq.items() if v >= min_freq}
    return word_freq

def create_charts(words, freqs, chart_type):
    """创建不同类型的图表"""
    if chart_type == "词云图":
        chart = (
            WordCloud()
            .add("", list(zip(words, freqs)), word_size_range=[20, 100])
            .set_global_opts(title_opts=opts.TitleOpts(title="词云图"))
        )
    elif chart_type == "柱状图":
        chart = (
            Bar()
            .add_xaxis(list(words))
            .add_yaxis("词频", list(freqs))
            .set_global_opts(
                title_opts=opts.TitleOpts(title="词频分布"),
                xaxis_opts=opts.AxisOpts(axislabel_opts=opts.LabelOpts(rotate=45))
            )
        )
    elif chart_type == "饼图":
        chart = (
            Pie()
            .add("", list(zip(words, freqs)))
            .set_global_opts(title_opts=opts.TitleOpts(title="词频占比"))
        )
    elif chart_type == "漏斗图":
        chart = (
            Funnel()
            .add("词频", list(zip(words, freqs)))
            .set_global_opts(title_opts=opts.TitleOpts(title="词频漏斗"))
        )
    elif chart_type == "折线图":
        chart = (
            Line()
            .add_xaxis(list(words))
            .add_yaxis("词频", list(freqs))
            .set_global_opts(
                title_opts=opts.TitleOpts(title="词频趋势"),
                xaxis_opts=opts.AxisOpts(axislabel_opts=opts.LabelOpts(rotate=45))
            )
        )
    elif chart_type == "散点图":
        chart = (
            Scatter()
            .add_xaxis(list(range(len(words))))
            .add_yaxis("词频", list(freqs))
            .set_global_opts(title_opts=opts.TitleOpts(title="词频散点"))
        )
    elif chart_type == "雷达图":
        chart = (
            Radar()
            .add_schema(
                schema=[
                    opts.RadarIndicatorItem(name=word, max_=max(freqs))
                    for word in words[:8]  # 雷达图最多显示8个维度
                ]
            )
            .add("词频", [list(freqs[:8])])
            .set_global_opts(title_opts=opts.TitleOpts(title="词频雷达"))
        )
    
    return chart

def main():
    # 侧边栏配置
    with st.sidebar:
        st.header("配置参数")
        min_freq = st.slider("最小词频", 1, 10, 2)
        chart_type = st.selectbox(
            "选择图表类型",
            ["词云图", "柱状图", "饼图", "漏斗图", "折线图", "散点图", "雷达图"]
        )
    
    # 主页面
    url = st.text_input("输入文章URL", placeholder="请输入要分析的文章网址...")
    
    if url:
        with st.spinner('正在获取文章内容...'):
            text = get_text_content(url)
            
        if text:
            with st.spinner('正在分析文本...'):
                word_freq = process_text(text, min_freq)
                
                if word_freq:
                    # 准备数据
                    items = sorted(word_freq.items(), key=lambda x: x[1], reverse=True)[:20]
                    words, freqs = zip(*items)
                    
                    # 显示词频统计
                    st.subheader("词频统计")
                    df = pd.DataFrame(items, columns=['词语', '频次'])
                    st.dataframe(df)
                    
                    # 显示图表
                    st.subheader("可视化图表")
                    chart = create_charts(words, freqs, chart_type)
                    st_pyecharts(chart)
                else:
                    st.warning("未能提取到有效词频数据")
        else:
            st.error("获取文章内容失败，请检查URL是否正确")

if __name__ == "__main__":
    main()
